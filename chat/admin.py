from django.contrib import admin
from .models import Room, ChatMessage, ChatMessagePack, ImageAttach, FileAttach


admin.site.register(
    Room,
    list_display=["id", "title", "staff_only"],
    list_display_links=["id", "title"],
)

admin.site.register(
    ChatMessage,
    list_display=['user', 'chat', 'id', 'message', 'created']

)

admin.site.register(
    ChatMessagePack,
    list_display=['id', 'chat', 'pack', 'created', 'previous', 'next']

)

admin.site.register(
    ImageAttach,
    list_display=["id", "attach", "image"],
    list_display_links=["id", "attach"],
)
admin.site.register(
    FileAttach,
    list_display=["id", "attach", "file"],
    list_display_links=["id", "attach"],
)

# @admin.register(ChatMessage)
# class AdminChatMessage(admin.ModelAdmin):
#     list_display = ['user', 'chat', 'message', 'created']
#     list_filter = ['user', 'created']
#     search_fields = ['message', 'created']
#     list_display_links = ['id', 'chat']
