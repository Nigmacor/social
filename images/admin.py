from django.contrib import admin
from .models import Image, Galary
# Register your models here.
@admin.register(Image)
class ImageAdmin(admin.ModelAdmin):
    list_display = ['title', 'slug', 'image', 'created']
    list_filter = ['created']

@admin.register(Galary)
class GalaryAdmin(admin.ModelAdmin):
    list_display = ['user', 'title', 'slug', 'created']
    list_filter = ['created']
