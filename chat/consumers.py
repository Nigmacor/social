import json
import redis
from django.conf import settings
from channels.generic.websocket import AsyncJsonWebsocketConsumer, AsyncWebsocketConsumer
from channels.db import database_sync_to_async
import datetime
import uuid
import magic
import mimetypes

from .exceptions import ClientError
from .utils import get_room_or_error
from .models import ChatMessage, ChatMessagePack, Room, Attach, ImageAttach, FileAttach
from images.models import Image


r = redis.StrictRedis(host=settings.REDIS_HOST, port=settings.REDIS_PORT, db=settings.REDIS_DB)


class ChatConsumer(AsyncJsonWebsocketConsumer):

    async def connect(self):

        # Они вошли в систему?
        if self.scope["user"].is_anonymous:
            # Отклонить соединение
            await self.close()
        else:
            # Принять соединение
            await self.accept()
        # Хранить, какие комнаты пользователь присоединился к этому соединению
        self.rooms = set()

    async def receive_json(self, content):
        """
        Вызывается, когда мы получаем текстовый фрейм. Channels will JSON-decode the payload
        for us and pass it as the first argument.
        """
        # Сообщения будут иметь «командную» клавишу, которую мы можем включить
        command = content.get("command", None)
        try:
            if command == "join":
                # Заставь их присоединиться к комнате
                await self.join_room(content["room"])
            elif command == "leave":
                # Покинуть комнату
                await self.leave_room(content["room"])
            elif command == "send":
                await self.send_room(content["room"], content["message"], content["attach_id"])
        except ClientError as e:
            # Ловит ошибки и отправляет их обратно
            await self.send_json({"error": e.code})

    async def disconnect(self, code):
        """
        Called when the WebSocket closes for any reason.
        """
        # Leave all the rooms we are still in
        for room_id in list(self.rooms):
            try:
                await self.leave_room(room_id)
            except ClientError:
                pass

    # Вспомогательные методы команд, вызываемые receive_json

    async def join_room(self, room_id):
        """
        Вызывается receive_json, когда кто-то отправил команду соединения.
        """
        # Зарегистрированный пользователь находится в нашей области благодаря аутентификации ASGI middleware

        room = await get_room_or_error(room_id, self.scope["user"])

        # Отправить сообщение о присоединении, если оно включено
        if settings.NOTIFY_USERS_ON_ENTER_OR_LEAVE_ROOMS:
            await self.channel_layer.group_send(
                room.group_name,
                {
                    "type": "chat.join",
                    "room_id": room_id,
                    "username": self.scope["user"].first_name,
                }
            )
        # Хранить, что пользователь в комнате
        self.rooms.add(room_id)
        # Добавьте их в группу, чтобы они получали сообщения комнаты
        await self.channel_layer.group_add(
            room.group_name,
            self.channel_name,
        )
        # Instruct their client to finish opening the room
        await self.send_json({
            "join": str(room.id),
            "title": room.title,
        })

    async def leave_room(self, room_id):
        """
        Called by receive_json when someone sent a leave command.
        """
        # Зарегистрированный пользователь находится в нашей области благодаря аутентификации ASGI middleware
        room = await get_room_or_error(room_id, self.scope["user"])
        # Отправить сообщение, если оно включено
        if settings.NOTIFY_USERS_ON_ENTER_OR_LEAVE_ROOMS:
            await self.channel_layer.group_send(
                room.group_name,
                {
                    "type": "chat.leave",
                    "room_id": room_id,
                    "username": self.scope["user"].first_name,
                }
            )
        # Remove that we're in the room
        self.rooms.discard(room_id)
        # Remove them from the group so they no longer get room messages
        await self.channel_layer.group_discard(
            room.group_name,
            self.channel_name,
        )
        # Instruct their client to finish closing the room
        await self.send_json({
            "leave": str(room.id),
        })

    async def send_room(self, room_id, message, attach_id):
        """
        Called by receive_json when someone sends a message to a room.
        """
        # Check they are in this room
        if room_id not in self.rooms:
            raise ClientError("ROOM_ACCESS_DENIED")
        # Get the room and send to the group about it
        room = await get_room_or_error(room_id, self.scope["user"])
        if attach_id.isdigit():
            await database_sync_to_async(Attach.objects.create)(user=self.scope['user'], room=room)
            attach = await database_sync_to_async(Attach.objects.get)(id=attach_id)
            await self.redis_message(room=room, message=message, attach_id=attach.id)
            attach = attach.get_attach_list()
        else:
            attach = ''
            await self.redis_message(room=room, message=message)

        await self.channel_layer.group_send(
            room.group_name,
            {
                "type": "chat.message",
                "room_id": room_id,
                "username": self.scope["user"].first_name,
                "user": self.scope["user"].id,
                "message": message,
                "avatar": str(self.scope["user"].profile.photo.url),
                "attach": attach,
            }
        )

    ##### Обработчики сообщений, отправленных через канальный слой

    # Эти вспомогательные методы называются по типам, которые мы отправляем, поэтому chat.join становится chat_join
    async def chat_join(self, event):
        """
        Вызывается, когда кто-то присоединился к нашему чату.
        """
        # Отправить сообщение клиенту
        await self.send_json(
            {
                "msg_type": settings.MSG_TYPE_ENTER,
                "room": event["room_id"],
                "username": event["username"],
            },
        )

    async def chat_leave(self, event):
        """
        Вызывается, когда кто-то покинул наш чат.
        """
        # Отправить сообщение клиенту
        await self.send_json(
            {
                "msg_type": settings.MSG_TYPE_LEAVE,
                "room": event["room_id"],
                "username": event["username"],
            },
        )

    async def chat_message(self, event):
        """
        Вызывается, когда кто-то отправил нам сообщение
        """
        # Отправить сообщение клиенту
        await self.send_json(
            {
                "msg_type": settings.MSG_TYPE_MESSAGE,
                "room": event["room_id"],
                "username": event["username"],
                "message": event["message"],
                "avatar": event["avatar"],
                "user": event["user"],
                "attach": event["attach"],
            },
        )

    # @database_sync_to_async
    def create_message(self, room, message):
        m = ChatMessage(user=self.scope['user'], chat=room, message=message)
        m.save()

    async def redis_message(self, room, message, attach_id=False):
        if message:
            mes_in_frame = 20
            redis_id = 'room:{}'.format(room.id)
            total_message = r.incr(redis_id + ':count')
            frame = {
                    'user': self.scope['user'].id,
                    'username': self.scope['user'].first_name,
                    'message': message,
                    'created': str(datetime.datetime.now()),
                    'room_id': room.id,
                    'message_id': str(total_message),
                    'attach_id': attach_id,
                    }
            str_frame = json.dumps(frame, ensure_ascii = False)
            r.set(redis_id + ':last_message', str_frame)
            r.rpush(redis_id, str_frame)
            if r.llen(redis_id) > mes_in_frame:
                print('do')
                save_frame = ''
                for mes in r.lrange(redis_id, 0, mes_in_frame):
                    save_frame = save_frame + str(mes.decode('utf-8')) + ';\n'
                save_frame = save_frame[:-2]
                await database_sync_to_async(self.save_messages)(room, save_frame, mes_in_frame)

    def save_messages(self, room, messages, num_of_mes):
        last_pack = r.get('room:{}:last_pack'.format(room.id))
        print('do_2')
        try:
            previous = ChatMessagePack.objects.get(pk=last_pack)
            m = ChatMessagePack(chat=room, pack=messages, previous=previous)
        except:
            m = ChatMessagePack(chat=room, pack=messages)
        m.save()
        r.ltrim('room:{}'.format(room.id), num_of_mes + 1, -1)
        r.set('room:{}:last_pack'.format(room.id), m.id)


class LoadhistoryConsumer(AsyncJsonWebsocketConsumer):
    async def connect(self):
        await self.accept()

    async def receive_json(self, content):
        privious_id = int(content['last_message_id'])
        if privious_id != -1:
            messages = []
            try:
                messages_pack = ChatMessagePack.objects.get(pk=privious_id)
                messages_in_p = messages_pack.pack.split(';\n')
                for m in messages_in_p:
                    message = json.loads(m)
                    messages.insert(0, message)
            except:
                pass

            try:
                privious_pack_id = messages_pack.previous.id
            except:
                privious_pack_id = -1
            await self.send_json({'messages': messages, 'privious_id': privious_pack_id})

    async def disconnect(self, code):
        pass


class FileConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        await self.accept()

    async def receive(self, text_data=None, bytes_data=None):
        if text_data:
            print(text_data)
            await self.send(text_data=json.dumps({'status': False}))
        if bytes_data:
            mime = magic.from_buffer(bytes_data[:32], mime=True)
            file_ext = mimetypes.MimeTypes().types_map_inv[1][mime][0]
            file_name ='{}{}'.format(uuid.uuid4().hex[:9], file_ext)
            path = settings.BASE_DIR + '\\media\\chats\\local\\' + file_name
            f = open(path, 'wb')
            f.write(bytes_data)
            f.close()
            print(mime)
            img_id = await database_sync_to_async(self.save_attach)('\\chats\\local\\' + file_name, mime)
            print('done: ' + path)
            await self.send(img_id)

    async def disconnect(self, code):
        pass

    def save_attach(self, path, mime):
        room = Room.objects.get(id=self.scope['url_route']['kwargs']['id'])
        attach = Attach.objects.filter(user=self.scope['user'], room=room).last()
        if not attach:
            attach = Attach.objects.create(user=self.scope['user'], room=room)
        if mime.startswith('image'):
            ImageAttach.objects.create(attach=attach, image=path)
        else:
            FileAttach.objects.create(attach=attach, file=path)
        return str(attach.id)
