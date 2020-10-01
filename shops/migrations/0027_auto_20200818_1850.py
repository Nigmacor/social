# Generated by Django 2.2.6 on 2020-08-18 13:50

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('shops', '0026_auto_20200522_2333'),
    ]

    operations = [
        migrations.AlterField(
            model_name='product',
            name='service_type',
            field=models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, related_name='product', to='shops.ServiceType'),
        ),
        migrations.AlterField(
            model_name='service',
            name='service_type',
            field=models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, related_name='service', to='shops.ServiceType'),
        ),
    ]
