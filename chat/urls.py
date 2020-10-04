from django.urls import path

from .views import index, room_list

app_name = 'chats'

urlpatterns = [
    path('', room_list, name='room_list'),
    path('<int:room_id>/', index, name='chat'),
]
# path('inspect/', ProjectInspect.as_view(), name='project_inspect')
