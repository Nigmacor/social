from django.contrib import admin
from mptt.admin import DraggableMPTTAdmin

from .models import Comment, Reply, ImageComment

# Register your models here.
@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ('id', 'product_or_service', 'author', 'date', 'rating', 'text', 'add_text', 'add_text_date')

@admin.register(Reply)
class ReplyAdmin(admin.ModelAdmin):
    list_display = ('id', 'comment', 'author', 'date', 'text')

@admin.register(ImageComment)
class ImageCommentAdmin(admin.ModelAdmin):
    list_display = ('id', 'comment', 'images_comment')
