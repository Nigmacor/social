import redis
import json
from django.conf import settings
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.http import Http404
from django.core.exceptions import ObjectDoesNotExist

from .models import Room, ChatMessagePack, Attach
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
        print(room)
    except:
        raise Http404
    # другой вариант
    pack_in_cach = r.lrange('room:{}'.format(room.id), 0, -1)
    print(r.llen('room:{}'.format(room.id)))
    last_pack = r.get('room:{}:last_pack'.format(room.id))
    messages = []
    try:
        messages_pack = ChatMessagePack.objects.get(pk=last_pack)
        messages_in_p = messages_pack.pack.split(';\n')
        for m in messages_in_p:
            message = json.loads(m)
            messages.append(message)
    except ObjectDoesNotExist:
        print('Нет паков')
    else:
        print('passssssssss')

    for m in pack_in_cach:
        message = json.loads(m.decode('utf-8'))
        messages.append(message)
    try:
        privious_pack_id = messages_pack.previous.id
    except:
        privious_pack_id = -1

    # Получить список комнат, упорядоченных по алфавиту
    # rooms = Room.objects.order_by("title")
    last_messages = []
    try:
        rooms = Room.objects.filter(members=request.user)
        for room in rooms:
            last_message = json.loads(r.get('room:{}:last_message'.format(room.id)) or "{}")
            last_messages.append(last_message)
    except:
        print('sssssssssssssssssssssaaapppp')

    return render(request, "chat/index.html", {
        "room": room,
        "room_id": room_id,
        "messages": messages,
        "privious_id": privious_pack_id,
        'user': request.user,
        'form': form,
        "rooms": rooms,
        'section': 'messages',

    })


@login_required
def room_list(request):

    # Получить список комнат, упорядоченных по алфавиту
    # rooms = Room.objects.order_by("title")
    last_messages = []
    rooms = Room.objects.filter(members=request.user)
    for room in rooms:
        last_message = json.loads(r.get('room:{}:last_message'.format(room.id)) or "{}")
        last_messages.append(last_message)
    # Визуализируйте это в шаблоне индекса
    return render(request, "chat/room_list.html", {
        "rooms": rooms,
        'section': 'messages',
        'last_messages': last_messages
    })


@login_required
def file_upload(request):
    print('Yes')
    return {'status': 'ok'}
