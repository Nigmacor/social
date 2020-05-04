from django.contrib import admin
import csv
import datetime
from django.http import HttpResponse
from django.urls import reverse
from django.utils.safestring import mark_safe
from .models import Order, OrderItem

# Register your models here.
def order_detail(obj):
    return mark_safe('<a href="{}">Подробнее</a>'.format(
        reverse('orders:admin_order_detail', args=[obj.id])))
order_detail.short_description = 'Детали'

def export_orders_csv(modeladmin, request, queryset):
    opts = modeladmin.model._meta
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename={}.csv'.format(opts.verbose_name)
    writer = csv.writer(response)
    fields = [field for field in opts.get_fields() if not field.many_to_many\
                and not field.one_to_many]
    writer.writerow([field.verbose_name for field in fields])
    for obj in queryset:
        data_row = []
        for field in fields:
            value = getattr(obj, field.name)
            if isinstance(value, datetime.datetime):
                value = value.strftime('%d/%m/%Y')
            data_row.append(value)
        writer.writerow(data_row)
    return response
export_orders_csv.short_description = 'Экспорт в CSV'

#настройка модели OrderItemInline для отображении ее на странице OrderAdmin
class OrderItemInline(admin.TabularInline):
    model = OrderItem
    raw_id_fields = ['product']

@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    def order_pdf(obj):
        return mark_safe('<a href="{}">PDF</a>'.format(
        reverse('orders:admin_order_pdf', args=[obj.id])))
    order_pdf.short_description = 'Чек заказа'

    list_display = ['id', 'user', 'paid', order_detail, order_pdf]
    list_filter = ['paid', 'created', 'updated']
    #связка с моделью OrderItemInline для отображении ее на странице OrderAdmin
    inlines = [OrderItemInline]
    actions = [export_orders_csv]
