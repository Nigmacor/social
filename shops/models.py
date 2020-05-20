from django.db import models
from django.shortcuts import reverse
from django.utils.text import slugify
from django.conf import settings
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey

from datetime import timedelta
from time import time
from mptt.models import MPTTModel, TreeForeignKey

from images.models import Image as abs_Image
from .fields import OrderField

# Create your models here.

def gen_slug(s):
    new_slug = slugify(s, allow_unicode=True)
    return new_slug + '-' + str(int(time()))

# Добавить модель персонала
class Shop(models.Model):
    owner = models.ForeignKey(settings.AUTH_USER_MODEL,
                             related_name='shops',
                             on_delete=models.CASCADE)
    name = models.CharField(max_length=92,
                            help_text='Название для владельца и персонала',
                            verbose_name='Название')
    employes = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='employer')
    slug = models.SlugField(max_length=92, unique=True)
    title = models.CharField(max_length=92,
                             help_text='Название для клиентов',
                             verbose_name='Вывеска')
    contact_email = models.EmailField(help_text="Контактный емайл для ЭТОГО магазина",
                                      default="contact@yourstore.com",
                                      verbose_name='Контактный e-mail')
    contact_phone = models.CharField(max_length=128,
                                     help_text="Контактный телефон для ЭТОГО магазина",
                                     default="",
                                     verbose_name='Контактный телефон')
    template_prefix = models.SlugField(max_length=92, help_text="obana.ru/THIS/...", unique=True)
    def __str__(self):
        return self.name


class Category(MPTTModel):
    name = models.CharField(max_length=200, db_index=True)
    slug = models.SlugField(max_length=200, db_index=True, unique=True)
    parent = TreeForeignKey('self', default=None, null=True, blank=True,
                            related_name='children', on_delete=models.CASCADE)

    class Meta:
        ordering = ('name',)
        verbose_name = 'Категория'
        verbose_name_plural = 'Категории'

    def __str__(self):
        return self.name
    def get_absolute_url(self):
        return reverse('shop_by_category', kwargs={'category_slug': self.slug})
    def get_ancestors(self):
        return super().get_ancestors(include_self=True)


class ServiceType(models.Model):

    def get_type_obj(self):
        try:
            return self.product
        except:
            return self.service


class AbstractService(models.Model):
    category = models.ForeignKey(Category, related_name='%(class)s', on_delete=models.CASCADE)
    shop = models.ForeignKey(Shop, related_name='%(class)s', on_delete=models.CASCADE)
    title = models.CharField(max_length=50, db_index=True, verbose_name='название')
    service_type = models.OneToOneField(ServiceType, blank=True, on_delete=models.CASCADE)
    slug = models.SlugField(max_length=150, blank=True, unique=True)
    short_description = models.CharField(max_length=200, blank=True)
    description  = models.TextField(blank=True)
    information = models.TextField(blank=True)
    available = models.BooleanField(default=True, verbose_name='Доступно')
    created = models.DateTimeField(auto_now_add=True, verbose_name='Опубликовано')
    updated = models.DateTimeField(auto_now=True, verbose_name='Изменено')

    def get_absolute_url(self):
        url_name = '{}_detail_url'.format(self._meta.model_name)
        return reverse(url_name, kwargs={'id': self.service_type.id, 'slug': self.slug})
    def get_content_list_url(self):
        return reverse('product_content_list', kwargs={'product_id': self.service_type.id})
    def __str__(self):
        return self.title
    class Meta:
        abstract = True


class Product(AbstractService):
    price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='Цена')
    county = models.PositiveIntegerField(verbose_name='Количество на складе')

    class Meta:
        verbose_name_plural = 'Товары'
        verbose_name = 'Товар'
        ordering = ['-price']
        index_together = (('id', 'slug'),)

class Service(AbstractService):

    class Meta:
        verbose_name_plural = 'Услуги'
        verbose_name = 'Услуга'
        ordering = ['category']
        index_together = (('id', 'slug'),)



# переделать через ContentType
class ProductGalary(models.Model):
    service = models.OneToOneField(ServiceType,
                                   on_delete=models.CASCADE,
                                   related_name='galary')
    main_image = models.URLField(blank=True, null=True)

    def __str__(self):
        try:
            return self.service.product.title
        except:
            return self.service.service.title

    class Meta:
        verbose_name_plural = 'Галереи товаров'
        verbose_name = 'Галерея товаров'

class ProductImage(abs_Image):
    galary = models.ForeignKey(ProductGalary,
                               on_delete=models.CASCADE,
                               related_name='images')
    is_main = models.BooleanField(default=False)

    class Meta:
        verbose_name_plural = 'Картинки товаров'
        verbose_name = 'Картинка товара'


# сделать загрузчик контента
class ProductContent(models.Model):
    product = models.ForeignKey(ServiceType,
                               related_name='contents',
                               on_delete=models.CASCADE)
    content_type = models.ForeignKey(ContentType,
                                     on_delete=models.CASCADE,
                                     limit_choices_to={'model__in':('text',
                                                                    'image',
                                                                    'file')})
    object_id = models.PositiveIntegerField()
    item = GenericForeignKey('content_type', 'object_id')
    order = OrderField(blank=True, for_fields=['product'])



class AbstractItem(models.Model):
    publisher = models.ForeignKey(settings.AUTH_USER_MODEL,
                                 related_name='%(class)s_for_shop',
                                 on_delete=models.PROTECT)
    product = models.ForeignKey(ServiceType,
                                related_name='%(class)s',
                                on_delete=models.CASCADE)
    title = models.CharField(max_length=250)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True

    def __str__(self):
        return self.title

class Text(AbstractItem):
    text = models.TextField()
class File(AbstractItem):
    file = models.FileField(upload_to='product/files/%Y/%m/%d/')
class Image(AbstractItem):
    image = models.ImageField(upload_to='product/images/%Y/%m/%d/')

'''
1) можно сделать один абстрактный класс из него наследовать Product и Service
2) переделать галереи и картинки на ContentType
 '''
