from django.db.models.signals import m2m_changed, pre_save
from django.dispatch import receiver
from .models import Image, Galary
from slugify import slugify
from time import time

@receiver(m2m_changed, sender=Image.users_like.through)
def users_like_changed(sender, instance, **kwargs):
    instance.total_likes = instance.users_like.count()
    instance.save()

@receiver(pre_save, sender=Image)
def change_slug(sender, instance, *args, **kwargs):
    if not instance.slug:
        instance.slug = slugify(instance.title, to_lower=True)  + '-' + str(int(time()))

@receiver(pre_save, sender=Galary)
def change_slug(sender, instance, *args, **kwargs):
    if not instance.slug:
        instance.slug = slugify(instance.title, to_lower=True)  + '-' + str(int(time()))
