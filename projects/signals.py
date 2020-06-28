from django.db.models.signals import post_save
from django.dispatch import receiver
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync

from .models import Module, ProjectRespond

channel_layer = get_channel_layer()

@receiver(post_save, sender=Module)
def activities(sender, instance, *args, **kwargs):
    async_to_sync(channel_layer.group_send)(instance.profession.group_name, {
        "type": "prochan.message",
        "profession_id": instance.profession.id,
        "username": instance.project.customer.username,
        "message": instance.title,
        "module_id": instance.id,
    })

@receiver(post_save, sender=ProjectRespond)
def activities(sender, instance, *args, **kwargs):
    async_to_sync(channel_layer.group_send)(instance.module.group_name, {
        "type": "module.respond",
        "username": instance.responded.username,
        "message": str(instance.cost),
        "module_id": instance.module.id,
    })
