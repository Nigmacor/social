# Generated by Django 2.2.6 on 2020-05-09 16:36

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('projects', '0002_content_typeofwork'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='content',
            name='content_type',
        ),
        migrations.RemoveField(
            model_name='content',
            name='module',
        ),
        migrations.RemoveField(
            model_name='module',
            name='producer',
        ),
        migrations.RemoveField(
            model_name='module',
            name='project',
        ),
        migrations.RemoveField(
            model_name='project',
            name='customer',
        ),
        migrations.RemoveField(
            model_name='typeofwork',
            name='parent',
        ),
        migrations.DeleteModel(
            name='Benchmark',
        ),
        migrations.DeleteModel(
            name='Content',
        ),
        migrations.DeleteModel(
            name='Module',
        ),
        migrations.DeleteModel(
            name='Project',
        ),
        migrations.DeleteModel(
            name='TypeOfWork',
        ),
    ]
