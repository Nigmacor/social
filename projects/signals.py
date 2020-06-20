from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Module
from actions.utils import create_action

@receiver(post_save, sender=Module)
def activities(sender, instance, *args, **kwargs):
    create_action(instance.project.customer, 'Добавил открыл проект', instance, type='work')
