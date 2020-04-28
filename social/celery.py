import os
from celery import Celery

# переменная окружения, содержащая название файла настроек проекта.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'social.settings')
app = Celery('social')

app.config_from_object('django.conf:settings', namespace='CELERY')

# поиск тасков
app.autodiscover_tasks()
