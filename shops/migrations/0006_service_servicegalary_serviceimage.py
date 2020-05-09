# Generated by Django 2.2.6 on 2020-05-05 14:07

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('images', '0006_auto_20200422_2253'),
        ('shops', '0005_remove_productgalary_main_image_pic'),
    ]

    operations = [
        migrations.CreateModel(
            name='Service',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(db_index=True, max_length=50, verbose_name='название')),
                ('slug', models.SlugField(blank=True, max_length=150, unique=True)),
                ('short_description', models.CharField(blank=True, max_length=200)),
                ('description', models.TextField(blank=True)),
                ('service_information', models.TextField(blank=True)),
                ('buy_counter', models.PositiveIntegerField(default=0, verbose_name='Покупок')),
                ('views', models.PositiveIntegerField(default=0, verbose_name='Просмотров')),
                ('available', models.BooleanField(default=True, verbose_name='Доступно')),
                ('created', models.DateTimeField(auto_now_add=True, verbose_name='Опубликовано')),
                ('updated', models.DateTimeField(auto_now=True, verbose_name='Изменено')),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='services', to='shops.Category')),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='services', to='shops.Shop')),
            ],
            options={
                'verbose_name': 'Услуга',
                'verbose_name_plural': 'Услуги',
                'ordering': ['buy_counter', 'views'],
                'index_together': {('id', 'slug')},
            },
        ),
        migrations.CreateModel(
            name='ServiceGalary',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('main_image', models.URLField(blank=True, null=True)),
                ('service', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='service_galary', to='shops.Service')),
            ],
            options={
                'verbose_name': 'Галерея услуг',
                'verbose_name_plural': 'Галереи услуг',
            },
        ),
        migrations.CreateModel(
            name='ServiceImage',
            fields=[
                ('image_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='images.Image')),
                ('is_main', models.BooleanField(default=False)),
                ('galary', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='images', to='shops.ServiceGalary')),
            ],
            options={
                'verbose_name': 'Картинка',
                'verbose_name_plural': 'Картинки',
            },
            bases=('images.image',),
        ),
    ]
