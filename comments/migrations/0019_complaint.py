# Generated by Django 2.2.6 on 2020-10-04 15:19

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('comments', '0018_auto_20200927_1536'),
    ]

    operations = [
        migrations.CreateModel(
            name='Complaint',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('complaint', models.CharField(max_length=50, verbose_name='Жалоба')),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='complaint_author', to=settings.AUTH_USER_MODEL, verbose_name='Автор жалобы')),
                ('comment', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='complaints', to='comments.Comment', verbose_name='Комментарий')),
            ],
        ),
    ]
