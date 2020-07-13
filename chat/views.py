import redis
import json
from django.conf import settings
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.http import Http404

from .models import Room, ChatMessage, ChatMessagePack
from .forms import ChatInputForm


r = redis.StrictRedis(host=settings.REDIS_HOST,
					  port=settings.REDIS_PORT,
					  db=settings.REDIS_DB)

@login_required
def index(request, room_id):
    """
    Root page view. This is essentially a single-page app, if you ignore the
    login and admin parts.
    """
    # Получить список комнат, упорядоченных по алфавиту
    # rooms = Room.objects.order_by("title")
    form = ChatInputForm()
    try:
        room = Room.objects.get(pk=room_id, members=request.user)
    except:
        raise Http404
    chat_queryset = room.messages.order_by('-created')[:10]
    chat_message_count = len(chat_queryset)
    if chat_message_count > 0:
        first_message_id = chat_queryset[chat_message_count - 1].id
    else:
        first_message_id = -1
        privious_id = -1
        chat_messages = []
    if first_message_id != -1:
        try:
            privious_id = ChatMessage.objects.filter(pk__lt=first_message_id).order_by('-pk')[:1][0].id
        except IndexError:
            privious_id = -1
        chat_messages = reversed(chat_queryset)
    # другой вариант
    previous_pack = r.get('room:{}:previous_pack'.format(room.id))
    print('***********')
    messages = []
    try:
        messages_pack = ChatMessagePack.objects.get(pk=previous_pack)
        messages_in_p = messages_pack.pack.split(';\n')
        for m in messages_in_p:
            message = json.loads(m)
            messages.append(message)
        print(messages)
        print('***********')
        print(messages[0]['message'])
    except:
        print('passsssssssssssssssssss')



    return render(request, "chat/index.html", {
        "rooms": room,
        "messages": messages,
        "privious_id": privious_id,
        "first_message_id": first_message_id,
        'user': request.user,
        'form': form,
        'section': 'messages',
    })


@login_required
def room_list(request):
    """
    Root page view. This is essentially a single-page app, if you ignore the
    login and admin parts.
    """
    # Получить список комнат, упорядоченных по алфавиту
    # rooms = Room.objects.order_by("title")
    rooms = Room.objects.filter(members=request.user)

    # Визуализируйте это в шаблоне индекса
    return render(request, "chat/room_list.html", {
        "rooms": rooms,
        'section': 'messages'
    })
