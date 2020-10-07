from django.urls import path

from .views import index, room_list, file_upload

app_name = 'chats'

urlpatterns = [
    path('room_list/', room_list, name='room_list'),
    path('<int:room_id>/', index, name='chat'),
    path('file/', file_upload, name='file_upload')
]
# path('inspect/', ProjectInspect.as_view(), name='project_inspect')
