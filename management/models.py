from django.db import models
from django.urls import reverse

from shops.models import ServiceType, Shop

# Create your models here.
class Statistics_shop(models.Model):
    shop = models.ForeignKey(Shop, related_name='stat_shop', on_delete=models.CASCADE, verbose_name='Магазин')
    views = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Просмотры товаров')
    amount_of_comments = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Комментарии товаров')
    orders = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Заказы')
    orders_cost = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Стоимость заказов')
    paid_orders = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Оплаченные заказы')
    paid_orders_cost = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Стоимость оплаченных заказов')
    in_cart = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='В корзине')
    rating = models.DecimalField(max_digits=999, decimal_places=2, default=0, verbose_name='Средний рейтинг товаров')
    quantity_of_products_and_services = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Количество товаров и услуг')

    def get_shop_info_url(self):
        return reverse('shop_info_url', kwargs={'id': self.id})

    def get_shop_stat_url(self):
        return reverse('shop_stat_url', kwargs={'id': self.id})


class Statistics(models.Model):
    product_or_service = models.ForeignKey(ServiceType, related_name='stat_product_or_service', on_delete=models.CASCADE, verbose_name='Продукт или услуга')
    st_shop = models.ForeignKey(Statistics_shop, related_name='stats_shop', on_delete=models.CASCADE, verbose_name='Статистика магазина', blank=True, null=True)
    views = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Просмотры')
    amount_of_comments = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Комментарии')
    orders = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Заказы')
    orders_cost = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Стоимость заказов')
    paid_orders = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Оплаченные заказы')
    paid_orders_cost = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='Стоимость оплаченных заказов')
    in_cart = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='В корзине')
    rating = models.DecimalField(max_digits=999, decimal_places=2, default=0, verbose_name='Рейтинг')
    type = models.CharField(max_length=100, verbose_name='Тип', blank=True, null=True)
    views_per_day = models.CharField(max_length=100000, verbose_name='Просмотры за день', default={})

    def get_product_info_url(self):
        return reverse('prod_info_url', kwargs={'id': self.id})

    def get_product_stat_url(self):
        return reverse('prod_stat_url', kwargs={'id': self.id})

    def get_product_stat_daily_url(self):
        return reverse('prod_stat_daily_url', kwargs={'id': self.id})

    def get_comments_stat_url(self):
        return reverse('comments_stat_url', kwargs={'id': self.id})


# class Statistics_user(models.Model):
#     user =
#     product_or_service = models.ForeignKey(ServiceType, related_name='stat_user_product_or_service', on_delete=models.CASCADE, verbose_name='Продукт или услуга')
#     in_cart_prod = models.DecimalField(max_digits=999, decimal_places=0, default=0, verbose_name='В корзине')
