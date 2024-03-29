from django.urls import path, include
from django.contrib.auth import views as auth_views
from . import views
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
# Определенные ранее обработчики.
    # здесь прописаны все Url к шаблонам templates\registration
    path('', views.dashboard, name='dashboard'),
    path('notifications/', views.notifications, name='notifications'),
    # path('in/', include('django.contrib.auth.urls')),
    # path('register/', views.register, name='register'),
    path('edit/', views.edit, name='edit'),
    path('professions/', views.professions, name='professions'),
    path('professions/add/', views.add_profession, name='add_profession'),
    path('users/follow/', views.user_follow, name='user_follow'),
    path('users/dialog/find/', views.dialog_find, name='dialog_find'),
    path('users/<int:id>/', views.user_detail, name='user_detail'),
    path('users/', views.user_list, name='user_list'),
]
# if settings.DEBUG:
#     urlpatterns += static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)
