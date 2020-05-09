from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from .models import Product, ProductGalary, ProductImage, ServiceGalary, ServiceImage
from actions.utils import create_action

@receiver(post_save, sender=Product)
def activities(sender, instance, *args, **kwargs):
    create_action(instance.shop.user, 'Добавил товар', instance, type='work')

@receiver(post_save, sender=ServiceImage)
@receiver(post_save, sender=ProductImage)
def get_main_image(sender, instance, *args, **kwargs):
    if instance.is_main:
        galary = instance._meta.get_field('galary').target_field.model.objects.get(pk=instance.galary.id)
        galary.main_image = instance.image.url
        galary.save()
