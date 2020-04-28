from django.contrib import admin
from .models import OrderItem, Order

# Register your models here.

#настройка модели OrderItemInline для отображении ее на странице OrderAdmin
class OrderItemInline(admin.TabularInline):
    model = OrderItem
    raw_id_fields = ['product']

@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'first_name', 'last_name', 'email',
                    'address', 'postal_code', 'city', 'paid',
                    'created', 'updated']
    list_filter = ['paid', 'created', 'updated']
    #связка с моделью OrderItemInline для отображении ее на странице OrderAdmin
    inlines = [OrderItemInline]
