from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Product
from actions.utils import create_action

@receiver(post_save, sender=Product)
def activities(sender, instance, *args, **kwargs):
    create_action(instance.shop.user, 'Добавил товар', instance, type='work')
