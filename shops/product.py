# from django.db import models

class AbstractItem(models.Model):
    category = models.ForeignKey(Category, related_name='%(class)s', on_delete=models.CASCADE)
    shop = models.ForeignKey(Shop, related_name='%(class)s', on_delete=models.CASCADE)
    title = models.CharField(max_length=50, db_index=True, verbose_name='название')
    slug = models.SlugField(max_length=150, blank=True, unique=True)
    short_description = models.CharField(max_length=200, blank=True)
    description  = models.TextField(blank=True)
    information = models.TextField(blank=True)
    buy_counter = models.PositiveIntegerField(verbose_name='Покупок', default=0)
    available = models.BooleanField(default=True, verbose_name='Доступно')
    created = models.DateTimeField(auto_now_add=True, verbose_name='Опубликовано')
    updated = models.DateTimeField(auto_now=True, verbose_name='Изменено')

    def get_absolute_url(self):
        url_name = '{}_detail_url'.format(self._meta.model_name)
        return reverse(url_name, kwargs={'id': self.id, 'slug': self.slug})
    def __str__(self):
        return self.title
    class Meta:
        abstract = True

class Product(AbstractItem):
    price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='Цена')
    county = models.PositiveIntegerField(verbose_name='Количество на складе')

    class Meta:
        verbose_name_plural = 'Товары'
        verbose_name = 'Товар'
        ordering = ['-price', 'buy_counter', 'views']
        index_together = (('id', 'slug'),)

class Service(AbstractItem):

    class Meta:
        verbose_name_plural = 'Услуги'
        verbose_name = 'Услуга'
        ordering = ['buy_counter', 'views']
        index_together = (('id', 'slug'),)
