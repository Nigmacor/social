from django.db import models
from django.conf import settings

# Create your models here.

class Profile(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL,
                                on_delete=models.CASCADE)
    date_of_birth = models.DateField(blank=True, null=True)
    photo = models.ImageField(upload_to='users/%Y/%m/%d/', blank=True)
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
