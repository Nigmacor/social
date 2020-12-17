from django.contrib import admin
from mptt.admin import DraggableMPTTAdmin

from .models import Statistics, Statistics_shop

# Register your models here.
@admin.register(Statistics)
class StatisticsAdmin(admin.ModelAdmin):
    list_display = ('id', 'product_or_service', 'st_shop', 'views', 'amount_of_comments', 'orders', 'orders_cost', 'paid_orders', 'paid_orders_cost', 'in_cart', 'rating', 'type')

@admin.register(Statistics_shop)
class Statistics_shopAdmin(admin.ModelAdmin):
    list_display = ('id', 'shop', 'views', 'amount_of_comments', 'orders', 'orders_cost', 'paid_orders', 'paid_orders_cost', 'in_cart', 'rating', 'quantity_of_products_and_services')
