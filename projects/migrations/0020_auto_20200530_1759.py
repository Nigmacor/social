# Generated by Django 2.2.6 on 2020-05-30 12:59

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('projects', '0019_auto_20200530_1755'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='family',
            name='children',
        ),
        migrations.RemoveField(
            model_name='family',
            name='level',
        ),
        migrations.RemoveField(
            model_name='family',
            name='lft',
        ),
        migrations.RemoveField(
            model_name='family',
            name='parent',
        ),
        migrations.RemoveField(
            model_name='family',
            name='rght',
        ),
        migrations.RemoveField(
            model_name='family',
            name='tree_id',
        ),
        migrations.RemoveField(
            model_name='module',
            name='level',
        ),
        migrations.RemoveField(
            model_name='module',
            name='lft',
        ),
        migrations.RemoveField(
            model_name='module',
            name='rght',
        ),
        migrations.RemoveField(
            model_name='module',
            name='tree_id',
        ),
        migrations.RemoveField(
            model_name='project',
            name='level',
        ),
        migrations.RemoveField(
            model_name='project',
            name='lft',
        ),
        migrations.RemoveField(
            model_name='project',
            name='rght',
        ),
        migrations.RemoveField(
            model_name='project',
            name='tree_id',
        ),
        migrations.AddField(
            model_name='family',
            name='childrens',
            field=models.ForeignKey(default=0, on_delete=django.db.models.deletion.CASCADE, related_name='childrens', to='projects.Module'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='family',
            name='parents',
            field=models.ForeignKey(default=0, on_delete=django.db.models.deletion.CASCADE, related_name='parents', to='projects.Module'),
            preserve_default=False,
        ),
    ]
