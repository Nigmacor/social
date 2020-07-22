from django.contrib import admin
from mptt.admin import DraggableMPTTAdmin

from .models import Shop, Product, ProductGalary, ProductImage, Category
from .models import Service, ProductContent, ServiceType

# Register your models here.
@admin.register(Shop)
class ShopAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'owner', 'title')
    prepopulated_fields = {'slug':('title',)}

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('title', 'price', 'county', 'available', 'created', 'updated')
    list_display_links = ('title',)
    search_fields = ('title', 'price', 'county', 'short_description', 'description', 'information')
    list_filter = ('available', 'county', 'price', 'created', 'updated', 'title')
    list_editable = ('price', 'county', 'available')
    prepopulated_fields = {'slug':('title',)}


@admin.register(ProductImage)
class ProductImageAdmin(admin.ModelAdmin):
    list_display = ['title', 'galary']

@admin.register(ProductGalary)
class ProductGalaryAdmin(admin.ModelAdmin):
    list_display = ['service']


@admin.register(Service)
class ServiceAdmin(admin.ModelAdmin):
    list_display = ('title', 'available', 'created', 'updated')
    list_display_links = ('title',)
    search_fields = ('title', 'short_description', 'description', 'information')
    list_filter = ('available', 'created', 'updated', 'title')
    list_editable = ('available',)
    prepopulated_fields = {'slug':('title',)}


@admin.register(ProductContent)
class ProductContentAdmin(admin.ModelAdmin):
    list_display = ('product', 'id')


@admin.register(ServiceType)
class ServiceTypeAdmin(admin.ModelAdmin):
    list_display = ('id',)


class CategoryDraggableMPTTAdmin(DraggableMPTTAdmin):
    list_display = ['name', 'slug']
    prepopulated_fields = {'slug': ('name',)}
    mptt_level_indent = 20
    def something(self, instance):
        return format_html(
            '<div style="text-indent:{}px">{}</div>',
            instance._mpttfield('level') * self.mptt_level_indent,
            instance.name
        )
admin.site.register(Category, CategoryDraggableMPTTAdmin,
    list_display=('tree_actions', 'indented_title'),
    list_display_links=('indented_title',)
    )
