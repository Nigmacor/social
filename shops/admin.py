from django.contrib import admin
from .models import Shop, Product, ProductGalary, ProductImage, Category
from mptt.admin import DraggableMPTTAdmin

# Register your models here.
@admin.register(Shop)
class ShopAdmin(admin.ModelAdmin):
    list_display = ('name', 'user', 'title')
    prepopulated_fields = {'slug':('title',)}

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('title', 'price', 'county', 'buy_counter', 'views', 'available', 'created', 'updated')
    list_display_links = ('title',)
    search_fields = ('title', 'price', 'county', 'buy_counter', 'views')
    list_filter = ('available', 'county', 'price', 'buy_counter', 'views', 'created', 'updated', 'title')
    list_editable = ('price', 'county', 'available')
    prepopulated_fields = {'slug':('title',)}


@admin.register(ProductGalary)
class ProductGalaryAdmin(admin.ModelAdmin):
    list_display = ['product']

@admin.register(ProductImage)
class ProductImageAdmin(admin.ModelAdmin):
    list_display = ['title', 'galary']

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
