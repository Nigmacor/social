# Generated by Django 2.2.6 on 2020-09-29 11:35

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('shops', '0001_squashed_0028_auto_20200929_1454'),
    ]

    operations = [
        migrations.AlterField(
            model_name='product',
            name='service_type',
            field=models.OneToOneField(blank=True, on_delete=django.db.models.deletion.CASCADE, to='shops.ServiceType'),
        ),
        migrations.AlterField(
            model_name='productgalary',
            name='service',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='galary', to='shops.ServiceType'),
        ),
        migrations.AlterField(
            model_name='service',
            name='service_type',
            field=models.OneToOneField(blank=True, on_delete=django.db.models.deletion.CASCADE, to='shops.ServiceType'),
        ),
    ]