# Generated by Django 2.2.6 on 2020-12-26 10:21

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Statistics',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('views', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Просмотры')),
                ('amount_of_comments', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Комментарии')),
                ('orders', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Заказы')),
                ('orders_cost', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Стоимость заказов')),
                ('paid_orders', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Оплаченные заказы')),
                ('paid_orders_cost', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Стоимость оплаченных заказов')),
                ('in_cart', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='В корзине')),
                ('rating', models.DecimalField(decimal_places=2, default=0, max_digits=999, verbose_name='Рейтинг')),
                ('type', models.CharField(blank=True, max_length=100, null=True, verbose_name='Тип')),
            ],
        ),
        migrations.CreateModel(
            name='Statistics_shop',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('views', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Просмотры товаров')),
                ('amount_of_comments', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Комментарии товаров')),
                ('orders', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Заказы')),
                ('orders_cost', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Стоимость заказов')),
                ('paid_orders', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Оплаченные заказы')),
                ('paid_orders_cost', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Стоимость оплаченных заказов')),
                ('in_cart', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='В корзине')),
                ('rating', models.DecimalField(decimal_places=2, default=0, max_digits=999, verbose_name='Средний рейтинг товаров')),
                ('quantity_of_products_and_services', models.DecimalField(decimal_places=0, default=0, max_digits=999, verbose_name='Количество товаров и услуг')),
            ],
        ),
    ]
