# Generated by Django 2.2.6 on 2020-04-21 14:16

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('actions', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='action',
            name='type',
            field=models.CharField(default='common', max_length=25),
        ),
    ]