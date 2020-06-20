from django.db import models
from django.shortcuts import reverse
from django.contrib.auth.models import User


class Room(models.Model):
    """
    A room for people to chat in.
    """
    title = models.CharField(max_length=50, verbose_name="Титул")
    # Если разрешены только "staff" пользователи (is_staff для пользователя django)

    staff_only = models.BooleanField(default=False)
    members = models.ManyToManyField(User, related_name='childs')

    def __str__(self):
        return '{}'.format(self.id)
    def get_absolute_url(self):
        return reverse('chat', kwargs={'room_id': self.id})

    @property
    def group_name(self):
        """
        Возвращает имя группы каналов, на которое должны быть подписаны сокеты, чтобы получать сообщения
        сообщения, как они генерируются.
        """
        return 'room-{}'.format(self.id)


class ChatMessage(models.Model):
    user = models.ForeignKey(User, related_name='messages', on_delete=models.CASCADE)
    chat = models.ForeignKey(Room, related_name='messages', on_delete=models.CASCADE)
    message = models.TextField()
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.message
