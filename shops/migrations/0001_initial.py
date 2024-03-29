# Generated by Django 2.2.6 on 2020-12-26 10:21

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import mptt.fields
import shops.fields


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('contenttypes', '0002_remove_content_type_name'),
        ('images', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(db_index=True, max_length=200)),
                ('slug', models.SlugField(max_length=200, unique=True)),
                ('lft', models.PositiveIntegerField(editable=False)),
                ('rght', models.PositiveIntegerField(editable=False)),
                ('tree_id', models.PositiveIntegerField(db_index=True, editable=False)),
                ('level', models.PositiveIntegerField(editable=False)),
                ('parent', mptt.fields.TreeForeignKey(blank=True, default=None, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='children', to='shops.Category')),
            ],
            options={
                'verbose_name': 'Категория',
                'verbose_name_plural': 'Категории',
                'ordering': ('name',),
            },
        ),
        migrations.CreateModel(
            name='ProductGalary',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('main_image', models.URLField(blank=True, max_length=500, null=True)),
            ],
            options={
                'verbose_name': 'Галерея товаров',
                'verbose_name_plural': 'Галереи товаров',
            },
        ),
        migrations.CreateModel(
            name='ServiceType',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('available', models.BooleanField(default=True, verbose_name='Доступно')),
            ],
        ),
        migrations.CreateModel(
            name='Slider',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=120)),
                ('main', models.BooleanField(default=True)),
            ],
        ),
        migrations.CreateModel(
            name='Wishlist',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('owner', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='wishlist', to=settings.AUTH_USER_MODEL)),
                ('products', models.ManyToManyField(blank=True, related_name='pot_clients', to='shops.ServiceType')),
            ],
        ),
        migrations.CreateModel(
            name='Text',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=250)),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('updated', models.DateTimeField(auto_now=True)),
                ('text', models.TextField()),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='text', to='shops.ServiceType')),
                ('publisher', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='text_for_shop', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Slide',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=120)),
                ('image', models.ImageField(upload_to='slider/images/%Y/%m/%d/')),
                ('slider', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='slides', to='shops.Slider')),
            ],
        ),
        migrations.CreateModel(
            name='Shop',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(help_text='Название для владельца и персонала', max_length=92, verbose_name='Название')),
                ('slug', models.SlugField(max_length=92, unique=True)),
                ('title', models.CharField(help_text='Название для клиентов', max_length=92, verbose_name='Вывеска')),
                ('contact_email', models.EmailField(default='contact@yourstore.com', help_text='Контактный емайл для ЭТОГО магазина', max_length=254, verbose_name='Контактный e-mail')),
                ('contact_phone', models.CharField(default='', help_text='Контактный телефон для ЭТОГО магазина', max_length=128, verbose_name='Контактный телефон')),
                ('template_prefix', models.SlugField(help_text='obana.ru/THIS/...', max_length=92, unique=True)),
                ('employes', models.ManyToManyField(related_name='employer', to=settings.AUTH_USER_MODEL)),
                ('owner', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='shops', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='ProductImage',
            fields=[
                ('image_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='images.Image')),
                ('is_main', models.BooleanField(default=False)),
                ('galary', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='images', to='shops.ProductGalary')),
            ],
            options={
                'verbose_name': 'Картинка товара',
                'verbose_name_plural': 'Картинки товаров',
            },
            bases=('images.image',),
        ),
        migrations.AddField(
            model_name='productgalary',
            name='service',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='galary', to='shops.ServiceType'),
        ),
        migrations.CreateModel(
            name='ProductContent',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('object_id', models.PositiveIntegerField()),
                ('order', shops.fields.OrderField(blank=True)),
                ('content_type', models.ForeignKey(limit_choices_to={'model__in': ('text', 'image', 'file')}, on_delete=django.db.models.deletion.CASCADE, to='contenttypes.ContentType')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='contents', to='shops.ServiceType')),
            ],
            options={
                'ordering': ['order'],
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
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='image', to='shops.ServiceType')),
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
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='file', to='shops.ServiceType')),
                ('publisher', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='file_for_shop', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Service',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(db_index=True, max_length=50, verbose_name='название')),
                ('slug', models.SlugField(blank=True, max_length=150, unique=True)),
                ('short_description', models.CharField(blank=True, max_length=500)),
                ('description', models.TextField(blank=True)),
                ('information', models.TextField(blank=True)),
                ('available', models.BooleanField(default=True, verbose_name='Доступно')),
                ('created', models.DateTimeField(auto_now_add=True, verbose_name='Опубликовано')),
                ('updated', models.DateTimeField(auto_now=True, verbose_name='Изменено')),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='service', to='shops.Category')),
                ('service_type', models.OneToOneField(blank=True, on_delete=django.db.models.deletion.CASCADE, to='shops.ServiceType')),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='service', to='shops.Shop')),
            ],
            options={
                'verbose_name': 'Услуга',
                'verbose_name_plural': 'Услуги',
                'ordering': ['category'],
                'index_together': {('id', 'slug')},
            },
        ),
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(db_index=True, max_length=50, verbose_name='название')),
                ('slug', models.SlugField(blank=True, max_length=150, unique=True)),
                ('short_description', models.CharField(blank=True, max_length=500)),
                ('description', models.TextField(blank=True)),
                ('information', models.TextField(blank=True)),
                ('available', models.BooleanField(default=True, verbose_name='Доступно')),
                ('created', models.DateTimeField(auto_now_add=True, verbose_name='Опубликовано')),
                ('updated', models.DateTimeField(auto_now=True, verbose_name='Изменено')),
                ('price', models.DecimalField(decimal_places=2, max_digits=10, verbose_name='Цена')),
                ('county', models.PositiveIntegerField(verbose_name='Количество на складе')),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='product', to='shops.Category')),
                ('service_type', models.OneToOneField(blank=True, on_delete=django.db.models.deletion.CASCADE, to='shops.ServiceType')),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='product', to='shops.Shop')),
            ],
            options={
                'verbose_name': 'Товар',
                'verbose_name_plural': 'Товары',
                'ordering': ['-price'],
                'index_together': {('id', 'slug')},
            },
        ),
    ]
