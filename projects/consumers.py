import json
from django.conf import settings
from channels.generic.websocket import AsyncJsonWebsocketConsumer
from channels.db import database_sync_to_async

from chat.exceptions import ClientError
from .utils import get_profession_or_error, get_module_or_error
from .models import Module, ProjectRespond





class ProfessionConsumer(AsyncJsonWebsocketConsumer):

    async def connect(self):

        # Они вошли в систему?
        if self.scope["user"].is_anonymous:
            # Отклонить соединение
            await self.close()
        else:
            # Принять соединение
            await self.accept()
        # Хранить, какие комнаты пользователь присоединился к этому соединению
        self.profession_channels = set()

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
                await self.join_prochan(content["profession"])
            elif command == "leave":
                # Покинуть комнату
                await self.leave_prochan(content["profession"])
        except ClientError as e:
            # Ловит ошибки и отправляет их обратно
            await self.send_json({"error": e.code})

    async def disconnect(self, code):
        """
        Called when the WebSocket closes for any reason.
        """
        # Leave all the professions we are still in
        for profession_id in list(self.profession_channels):
            try:
                await self.leave_prochan(profession_id)
            except ClientError:
                pass

    ##### Вспомогательные методы команд, вызываемые receive_json

    async def join_prochan(self, profession_id):
        """
        Вызывается receive_json, когда кто-то отправил команду соединения.
        """
        # Зарегистрированный пользователь находится в нашей области благодаря аутентификации ASGI middleware

        profession = await get_profession_or_error(profession_id, self.scope["user"])


        # Хранить, что пользователь в комнате
        self.profession_channels.add(profession_id)
        # Добавьте их в группу, чтобы они получали сообщения комнаты
        await self.channel_layer.group_add(
            profession.group_name,
            self.channel_name,
        )
        # Instruct their client to finish opening the profession
        await self.send_json({
            "join": str(profession.id),
            "title": profession.title,
        })

    async def leave_prochan(self, profession_id):
        """
        Called by receive_json when someone sent a leave command.
        """
        # Зарегистрированный пользователь находится в нашей области благодаря аутентификации ASGI middleware
        profession = await get_profession_or_error(profession_id, self.scope["user"])

        # Remove that we're in the profession
        self.profession_channels.discard(profession_id)
        # Remove them from the group so they no longer get profession messages
        await self.channel_layer.group_discard(
            profession.group_name,
            self.channel_name,
        )
        # Instruct their client to finish closing the profession
        await self.send_json({
            "leave": str(profession.id),
        })


    ##### Обработчики сообщений, отправленных через канальный слой

    # Эти вспомогательные методы называются по типам, которые мы отправляем, поэтому chat.join становится chat_join


    async def prochan_message(self, event):
        """
        Вызывается, когда кто-то отправил нам сообщение
        """
        # Отправить сообщение клиенту
        await self.send_json(
            {
                "msg_type": settings.MSG_TYPE_MESSAGE,
                "profession": event["profession_id"],
                "username": event["username"],
                "message": event["message"],
                "module_id": event["module_id"],
            },
        )

class LoadModuleConsumer(AsyncJsonWebsocketConsumer):
    async def connect(self):
        await self.accept()

    async def receive_json(self, content):
        profession = await get_profession_or_error(content['profession'], self.scope["user"])
        profession_queryset = profession.modules.filter(id__lte=content['last_message_id']).order_by('-id')[:10]
        profession_message_count = len(profession_queryset)
        if profession_message_count > 0:
            first_message_id = profession_queryset[profession_message_count - 1].id
        else:
            first_message_id = -1
            privious_id = -1
        if first_message_id != -1:
            try:
                privious_id = Module.objects.filter(pk__lt=first_message_id).order_by('-pk')[:1][0].id
            except IndexError:
                privious_id = -1
            # chat_messages = reversed(chat_queryset)
            cleaned_profession_message = list()
            for item in profession_queryset:
                cleaned_item = {'username': item.project.customer.username,
                                'message': item.title,
                                'created': item.id,
                                }
                cleaned_profession_message.append(cleaned_item)
            await self.send_json({'messages': cleaned_profession_message, 'privious_id': privious_id})
    async def disconnect(self, code):
        pass


class RespondConsumer(AsyncJsonWebsocketConsumer):

    async def connect(self):

        # Они вошли в систему?
        if self.scope["user"].is_anonymous:
            # Отклонить соединение
            await self.close()
        else:
            # Принять соединение
            await self.accept()
        # Хранить, какие комнаты пользователь присоединился к этому соединению
        self.modules = set()

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
                await self.join_module(content["module"])
            elif command == "leave":
                # Покинуть комнату
                await self.leave_module(content["module"])
            elif command == "send":
                await self.send_module(content["module"], content["message"])
        except ClientError as e:
            # Ловит ошибки и отправляет их обратно
            await self.send_json({"error": e.code})

    async def disconnect(self, code):
        """
        Called when the WebSocket closes for any reason.
        """
        # Leave all the modules we are still in
        for module_id in list(self.modules):
            try:
                await self.leave_module(module_id)
            except ClientError:
                pass

    ##### Вспомогательные методы команд, вызываемые receive_json

    async def join_module(self, module_id):
        """
        Вызывается receive_json, когда кто-то отправил команду соединения.
        """
        # Зарегистрированный пользователь находится в нашей области благодаря аутентификации ASGI middleware
        module = await get_module_or_error(module_id, self.scope["user"])
        # Отправить сообщение о присоединении, если оно включено
        if settings.NOTIFY_USERS_ON_ENTER_OR_LEAVE_ROOMS:
            await self.channel_layer.group_send(
                module.group_name,
                {
                    "type": "chat.join",
                    "module_id": module_id,
                    "username": self.scope["user"].username,
                }
            )
        # Хранить, что пользователь в комнате
        self.modules.add(module_id)
        # Добавьте их в группу, чтобы они получали сообщения комнаты
        await self.channel_layer.group_add(
            module.group_name,
            self.channel_name,
        )
        # Instruct their client to finish opening the module
        await self.send_json({
            "join": str(module.id),
            "title": module.title,
        })

    async def leave_module(self, module_id):
        """
        Called by receive_json when someone sent a leave command.
        """
        # Зарегистрированный пользователь находится в нашей области благодаря аутентификации ASGI middleware
        module = await get_module_or_error(module_id, self.scope["user"])
        # Отправить сообщение, если оно включено
        if settings.NOTIFY_USERS_ON_ENTER_OR_LEAVE_ROOMS:
            await self.channel_layer.group_send(
                module.group_name,
                {
                    "type": "chat.leave",
                    "module_id": module_id,
                    "username": self.scope["user"].username,
                }
            )
        # Remove that we're in the module
        self.modules.discard(module_id)
        # Remove them from the group so they no longer get module messages
        await self.channel_layer.group_discard(
            module.group_name,
            self.channel_name,
        )
        # Instruct their client to finish closing the module
        await self.send_json({
            "leave": str(module.id),
        })


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
                "module": event["module_id"],
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
                "module": event["module_id"],
                "username": event["username"],
            },
        )

    async def module_respond(self, event):
        """
        Вызывается, когда кто-то отправил нам сообщение
        """
        # Отправить сообщение клиенту
        await self.send_json(
            {
                "msg_type": settings.MSG_TYPE_MESSAGE,
                "module": event["module_id"],
                "username": event["username"],
                "message": event["message"],
            },
        )

class LoadRespondConsumer(AsyncJsonWebsocketConsumer):
    async def connect(self):
        await self.accept()

    async def receive_json(self, content):
        module = await get_module_or_error(content['module'], self.scope["user"])
        module_queryset = module.responds.filter(id__lte=content['last_message_id']).order_by('-id')[:10]
        module_respond_count = len(module_queryset)

        if module_respond_count > 0:
            first_message_id = module_queryset[module_respond_count - 1].id
        else:
            first_message_id = -1
            privious_id = -1
        if first_message_id != -1:
            try:
                privious_id = ProjectRespond.objects.filter(pk__lt=first_message_id).order_by('-pk')[:1][0].id
            except IndexError:
                privious_id = -1
            # chat_messages = reversed(chat_queryset)
            cleaned_module_respond = list()

            for item in module_queryset:
                cleaned_item = {'username': item.responded.username,
                                'message': item.description,
                                'created': item.id,
                                }
                cleaned_module_respond.append(cleaned_item)
            await self.send_json({'messages': cleaned_module_respond, 'module': content['module'], 'privious_id': privious_id})
        else:
            await self.send_json({'messages': [], 'module': content['module'], 'privious_id': privious_id})

    async def disconnect(self, code):
        pass
