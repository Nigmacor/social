# Generated by Django 2.2.6 on 2020-09-15 17:11

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('comments', '0007_auto_20200915_2140'),
    ]

    operations = [
        migrations.AddField(
            model_name='comment',
            name='add_text_date',
            field=models.DateTimeField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
    ]