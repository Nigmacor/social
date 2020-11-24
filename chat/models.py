from django.db import models
from django.shortcuts import reverse
from django.contrib.auth.models import User
from django.contrib.postgres.fields import JSONField


class Room(models.Model):
    """
    A room for people to chat in.
    """
    title = models.CharField(max_length=50, verbose_name="Титул")
    # Если разрешены только "staff" пользователи (is_staff для пользователя django)

    staff_only = models.BooleanField(default=False)
    members = models.ManyToManyField(User, related_name='chats')

    def __str__(self):
        return '{}'.format(self.id)
    def get_absolute_url(self):
        return reverse('chats:chat', kwargs={'room_id': self.id})

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
    # pack = JSONField()

    def __str__(self):
        return self.message


class ChatMessagePack(models.Model):
    chat = models.ForeignKey(Room, related_name='messages_pack', on_delete=models.CASCADE)
    pack = models.TextField()
    created = models.DateTimeField(auto_now_add=True)
    previous = models.OneToOneField('self',
                                    related_name='next',
                                    on_delete=models.SET_NULL,
                                    null=True, blank=True)

    def __str__(self):
        return '{}:{}'.format(self.chat.id, self.id)


# сделать, чтоб Attach по ForeignKey мог прикрепиться к ChatMessagePack
class Attach(models.Model):
    room = models.ForeignKey(Room, blank=True, on_delete=models.CASCADE)
    user = models.ForeignKey(User, blank=True, on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)

    def get_attach_list(self):
        try:
            return [item.image.url for item in self.image.all()]
        except AttributeError:
            return [item.file.url for item in self.file.all()]





class ImageAttach(models.Model):
    attach = models.ForeignKey(Attach, related_name='image', on_delete=models.CASCADE)
    image = models.ImageField(upload_to='images/%Y/%m/%d/')

class FileAttach(models.Model):
    attach = models.ForeignKey(Attach, related_name='file', on_delete=models.CASCADE)
    file = models.FileField(upload_to='images/%Y/%m/%d/')
