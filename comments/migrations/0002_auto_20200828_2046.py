# Generated by Django 2.2.6 on 2020-08-28 15:46

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('comments', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='comment',
            old_name='service_or_product',
            new_name='product_or_service',
        ),
    ]
