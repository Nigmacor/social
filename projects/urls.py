from django.urls import path
from .views import ProjectCreate


urlpatterns = [
    path('create/', ProjectCreate.as_view(), name='project_create'),
]
# path('inspect/', ProjectInspect.as_view(), name='project_inspect')
