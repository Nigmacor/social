from django.db import models
from django.shortcuts import reverse
from django.utils.text import slugify
from django.conf import settings

from datetime import timedelta
from time import time
from mptt.models import MPTTModel, TreeForeignKey

from images.models import Image

# Create your models here.

def gen_slug(s):
    new_slug = slugify(s, allow_unicode=True)
    return new_slug + '-' + str(int(time()))


class Shop(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL,
                             related_name='shops',
                             on_delete=models.CASCADE)
    name = models.CharField(max_length=92, help_text='Название для владельца и персонала')
    slug = models.SlugField(max_length=92, unique=True)
    title = models.CharField(max_length=92, help_text='Название для клиентов')
    contact_email = models.EmailField(help_text="Контактный емайл для ЭТОГО магазина", default="contact@yourstore.com")
    contact_phone = models.CharField(max_length=128, help_text="Контактный телефон для ЭТОГО магазина", default="")
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

class Product(models.Model):
    category = models.ForeignKey(Category, related_name='products', on_delete=models.CASCADE)
    shop = models.ForeignKey(Shop, related_name='products', on_delete=models.CASCADE)
    title = models.CharField(max_length=50, db_index=True, verbose_name='название')
    slug = models.SlugField(max_length=150, blank=True, unique=True)
    short_description = models.CharField(max_length=200, blank=True)
    description  = models.TextField(blank=True)
    product_information = models.TextField(blank=True)
    price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='Цена')
    county = models.PositiveIntegerField(verbose_name='Количество на складе')
    buy_counter = models.PositiveIntegerField(verbose_name='Покупок', default=0)
    views = models.PositiveIntegerField(verbose_name='Просмотров', default=0)
    available = models.BooleanField(default=True, verbose_name='Доступно')
    created = models.DateTimeField(auto_now_add=True, verbose_name='Опубликовано')
    updated = models.DateTimeField(auto_now=True, verbose_name='Изменено')

    class Meta:
        verbose_name_plural = 'Товары'
        verbose_name = 'Товар'
        ordering = ['-price', 'buy_counter', 'views']
        index_together = (('id', 'slug'),)


    def get_absolute_url(self):
        return reverse('product_detail_url', kwargs={'id': self.id, 'slug': self.slug})
    def __str__(self):
        return self.title

class ProductGalary(models.Model):
    product = models.OneToOneField(Product,
                                   on_delete=models.CASCADE,
                                   related_name='product_galary')
    main_image = models.URLField(blank=True, null=True)

    def __str__(self):
        return self.product.title

    class Meta:
        verbose_name_plural = 'Галереи товаров'
        verbose_name = 'Галерея товаров'

class ProductImage(Image):
    galary = models.ForeignKey(ProductGalary,
                               on_delete=models.CASCADE,
                               related_name='images')
    is_main = models.BooleanField(default=False)

    class Meta:
        verbose_name_plural = 'Картинки'
        verbose_name = 'Картинка'
