from channels.db import database_sync_to_async

from account.models import Profession
from .models import Module
from chat.exceptions import ClientError


@database_sync_to_async
def get_profession_or_error(profession_id, user):
    """
    Tries to fetch a room for the user, checking permissions along the way.
    """
    # Проверьте, вошел ли пользователь в систему
    if not user.is_authenticated:
        raise ClientError("USER_HAS_TO_LOGIN")
    # Найдите комнату, которую они просили (по ID)
    try:
        profession = Profession.objects.get(pk=profession_id)
    except Profession.DoesNotExist:
        raise ClientError("JOD_CHANNEL_INVALID")
    # Проверьте разрешения
    for prof in user.profile.rel_to_profession.all():
        if prof.profession == profession and prof.confirmed:
            return prof.profession
    else:
        raise ClientError("USER_HAS_NO_PERMISSION")

    if profession not in user.profile.rel_to_profession.all():
        raise ClientError("CHANNEL_ACCESS_DENIED")


@database_sync_to_async
def get_module_or_error(module_id, user):
    """
    Tries to fetch a room for the user, checking permissions along the way.
    """
    # Проверьте, вошел ли пользователь в систему
    if not user.is_authenticated:
        raise ClientError("USER_HAS_TO_LOGIN")
    # Найдите комнату, которую они просили (по ID)
    try:
        module = Module.objects.get(pk=module_id, project__customer=user)
    except Module.DoesNotExist:
        raise ClientError("JOD_CHANNEL_INVALID")
    # Проверьте разрешения
    return module
