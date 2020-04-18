from django.db import models
from django.conf import settings
from django.contrib.auth.models import User

# Create your models here.

class Profile(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL,
                                on_delete=models.CASCADE)
    date_of_birth = models.DateField(blank=True, null=True)
    photo = models.ImageField(upload_to='users/%Y/%m/%d/', blank=True)
    professions = models.ManyToManyField('Profession', through='ProfileToProfession')
    def __str__(self):
        return 'Profile for user {}'.format(self.user.username)


class Profession(models.Model):
    title = models.CharField(max_length=200)
    slug = models.SlugField(max_length=200, blank=True)
    url = models.URLField()
    description = models.TextField(blank=True)


class ProfileToProfession(models.Model):
    worker = models.ForeignKey(Profile, related_name='rel_to_profession',
                               on_delete=models.CASCADE)
    profession = models.ForeignKey(Profession, related_name='rel_to_worker',
                                   on_delete=models.CASCADE)
    confirmed = models.BooleanField(default=False)


class Contact(models.Model):
    user_from = models.ForeignKey('auth.User',
                                  related_name='rel_from_set',
                                  on_delete=models.CASCADE)
    user_to = models.ForeignKey('auth.User', related_name='rel_to_set',
                                on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True, db_index=True)
    class Meta:
        ordering = ('-created',)
        def __str__(self):
            return 'подписаны: {};\n  подписан на:{}'.format(self.user_from, self.user_to)

# Динамическое добавление поля following, избавиться при первой возможности
User.add_to_class('following', models.ManyToManyField('self',
                                                      through=Contact,
                                                      related_name='followers',
                                                      symmetrical=False))
