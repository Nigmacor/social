# Generated by Django 2.2.6 on 2020-09-17 17:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('comments', '0010_auto_20200917_2217'),
    ]

    operations = [
        migrations.AlterField(
            model_name='comment',
            name='rating',
            field=models.DecimalField(decimal_places=0, max_digits=1, verbose_name='Оценка'),
        ),
    ]