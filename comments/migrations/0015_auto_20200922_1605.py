# Generated by Django 2.2.6 on 2020-09-22 11:05

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('comments', '0014_auto_20200922_0005'),
    ]

    operations = [
        migrations.AlterField(
            model_name='comment',
            name='image',
            field=models.ImageField(blank=True, null=True, upload_to='comments/%Y/%m/%d/', verbose_name='Изображение'),
        ),
    ]
