from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from .models import Shop, Product, Service, ProductGalary, ProductImage, \
ServiceType
from actions.utils import create_action

@receiver(post_save, sender=Service)
@receiver(post_save, sender=Product)
def activities(sender, instance, created,  *args, **kwargs):
    if created:
        create_action(instance.shop.owner, 'Добавил продукт', instance, type='work')
    else:
        create_action(instance.shop.owner, 'Обновил продукт', instance, type='work')

@receiver(pre_save, sender=Service)
@receiver(pre_save, sender=Product)
def get_service_type(sender, instance, *args, **kwargs):
    try:
        if not instance.service_type:
            obj = ServiceType.objects.create()
            instance.service_type = obj
    except:
        obj = ServiceType.objects.create()
        galary = ProductGalary.objects.create(service=obj)
        instance.service_type = obj

@receiver(post_save, sender=ProductImage)
def get_main_image(sender, instance, *args, **kwargs):
    if instance.is_main:
        galary = instance._meta.get_field('galary').target_field.model.objects.get(pk=instance.galary.id)
        galary.main_image = instance.image.url
        galary.save()

@receiver(post_save, sender=Shop)
def create_shop(sender, instance, *args, **kwargs):
    if not instance.employes:
        instance.employes.add(instance.owner)
