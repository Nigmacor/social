# Generated by Django 2.2.6 on 2020-04-16 09:39

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Profession',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=200)),
                ('slug', models.SlugField(blank=True, max_length=200)),
                ('url', models.URLField()),
                ('description', models.TextField(blank=True)),
            ],
        ),
        migrations.CreateModel(
            name='ProfileToProfession',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('confirmed', models.BooleanField(default=False)),
                ('profession', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='rel_to_worker', to='account.Profession')),
                ('worker', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='rel_to_profession', to='account.Profile')),
            ],
        ),
        migrations.AddField(
            model_name='profile',
            name='profession',
            field=models.ManyToManyField(through='account.ProfileToProfession', to='account.Profession'),
        ),
    ]
