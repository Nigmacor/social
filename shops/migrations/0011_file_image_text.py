# Generated by Django 2.2.6 on 2020-05-16 18:19

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('shops', '0010_auto_20200516_2318'),
    ]

    operations = [
        migrations.CreateModel(
            name='Text',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=250)),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('updated', models.DateTimeField(auto_now=True)),
                ('content', models.TextField()),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='text', to='shops.Product')),
                ('publisher', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='text_for_shop', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Image',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=250)),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('updated', models.DateTimeField(auto_now=True)),
                ('image', models.ImageField(upload_to='product/images/%Y/%m/%d/')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='image', to='shops.Product')),
                ('publisher', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='image_for_shop', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='File',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=250)),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('updated', models.DateTimeField(auto_now=True)),
                ('file', models.FileField(upload_to='product/files/%Y/%m/%d/')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='file', to='shops.Product')),
                ('publisher', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='file_for_shop', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'abstract': False,
            },
        ),
    ]
