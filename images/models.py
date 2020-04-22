from django.db import models
from django.conf import settings
from django.urls import reverse
from shops.models import Shop

# Create your models here.
class Image(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL,
                            related_name='images_created',
                            on_delete=models.CASCADE)
    title = models.CharField(max_length=200)
    slug = models.SlugField(max_length=255, blank=True)
    url = models.URLField()
    image = models.ImageField(upload_to='images/%Y/%m/%d/')
    description = models.TextField(blank=True)
    created = models.DateTimeField(auto_now_add=True, db_index=True)
    users_like = models.ManyToManyField(settings.AUTH_USER_MODEL,
                                        related_name='images_liked',
                                        blank=True)
    total_likes = models.PositiveIntegerField(db_index=True, default=0)
    is_public = models.BooleanField(default=True)




    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('images:detail', kwargs={'id': self.id, 'slug': self.slug})

    class Meta:
        ordering = ['created']
        verbose_name_plural = 'Картинки'
        verbose_name = 'Картинка'


class Galary(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL,
                            related_name='galaries',
                            on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True, db_index=True)
    title = models.CharField(max_length=200, default='basic')
    slug = models.SlugField(max_length=255, blank=True)

    class Meta:
        ordering = ['created']
        verbose_name_plural = 'Галереи'
        verbose_name = 'Галерея'
