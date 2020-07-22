# Generated by Django 2.2.6 on 2020-06-08 08:14

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('chat', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='room',
            name='members',
            field=models.ManyToManyField(related_name='childs', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='room',
            name='title',
            field=models.CharField(max_length=50, verbose_name='Титул'),
        ),
    ]
