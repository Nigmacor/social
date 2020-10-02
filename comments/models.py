from django.db import models
from django.urls import reverse
from django.conf import settings
from datetime import datetime

from shops.models import ServiceType

# Create your models here.
class Comment(models.Model):
    product_or_service = models.ForeignKey(ServiceType, related_name='comment_product_or_service', on_delete=models.CASCADE, verbose_name='Продукт или услуга', blank=True, null=True)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, related_name='comment_author', on_delete=models.CASCADE, verbose_name='Автор комментария')
    date = models.DateTimeField(auto_now_add=True)
    rating = models.DecimalField(max_digits=1, decimal_places=0, verbose_name='Оценка')
    text = models.CharField(max_length=500, verbose_name='Текст комментария')
    add_text = models.TextField(verbose_name='Текст дополнения', default='')
    add_text_date = models.DateTimeField(auto_now=True)

    def get_update_url(self):
        return reverse('comment_update_url', kwargs={'id': self.id,
                                                     'id_p': self.product_or_service.id})

    def get_delete_url(self):
        return reverse('comment_delete_url', kwargs={'id': self.id,
                                                     'id_p': self.product_or_service.id})

    def get_reply_url(self):
        return reverse('reply_url', kwargs={'id': self.id,
                                            'id_p': self.product_or_service.id})


    class Meta:
        ordering = ['-date']


class Reply(models.Model):
    comment = models.ForeignKey(Comment, related_name='reply', on_delete=models.CASCADE, verbose_name='Комментарий')
    author = models.ForeignKey(settings.AUTH_USER_MODEL, related_name='reply_author', on_delete=models.CASCADE, verbose_name='Автор дополнения к комментарию')
    date = models.DateTimeField(auto_now_add=True)
    text = models.CharField(max_length=255, verbose_name='Текст дополнения к комментарию')

    def get_reply_delete_url(self):
        return reverse('reply_delete_url', kwargs={'id': self.id,
                                                   'id_c': self.comment.id})


class ImageComment(models.Model):
    comment = models.ForeignKey(Comment, related_name='images', on_delete=models.CASCADE, verbose_name='Комментарий')
    images_comment = models.ImageField(upload_to='comments/%Y/%m/%d/', verbose_name='Изображения', blank=True, null=True)
