from channels.db import database_sync_to_async
from .exceptions import ClientError
from .models import Room, ChatMessage


@database_sync_to_async
def get_room_or_error(room_id, user):
    """
    Tries to fetch a room for the user, checking permissions along the way.
    """
    # Проверьте, вошел ли пользователь в систему
    if not user.is_authenticated:
        raise ClientError("USER_HAS_TO_LOGIN")
    # Найдите комнату, которую они просили (по ID)
    try:
        room = Room.objects.get(pk=room_id)
    except Room.DoesNotExist:
        raise ClientError("ROOM_INVALID")
    # Проверьте разрешения
    if room.staff_only and not user.is_staff:
        raise ClientError("ROOM_ACCESS_DENIED")
    return room
