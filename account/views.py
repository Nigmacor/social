from django.shortcuts import render, get_object_or_404, redirect, reverse
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib import messages
from django.views.decorators.http import require_POST

from common.mixin import image_list_mixin
from common.decorators import ajax_required
from actions.utils import create_action

from .models import Profile, Contact, Profession, ProfileToProfession, Dialogs
from images.models import Galary
from .forms import UserRegistrationForm, UserEditForm, ProfileEditForm
from actions.models import Action
from shops.models import Shop
from chat.models import Room
#from django.contrib.auth import authenticate, login
# from .forms import LoginForm

# Create your views here.
@login_required
def dashboard(request):
    #По умолчанию отображаются действия всех пользователей
    actions = Action.objects.exclude(user=request.user)
    work_actions = actions.exclude(type='common')
    actions = actions.exclude(type='work')
    following_ids = request.user.following.values_list('id', flat=True)
    if following_ids:
        # Если текущий пользователь подписался на кого-то,
        # отображаем только действия этих пользователей.
        actions = actions.filter(user_id__in=following_ids, type='common')
    #select_related в запросе к юзеру возвращает и профиль, работает с
    #«один  ко  многим» и «один  к одному»
    #prefetch_related также но работает с «многие ко многим» и «многие к одному»
    actions = actions.select_related('user', 'user__profile').prefetch_related('target')[:10]
    return render(request, 'account/dashboard.html',
                  {'section': 'dashboard', 'actions': actions, 'work_actions': work_actions})

@login_required
def notifications(request):
    #По умолчанию отображаются действия всех пользователей
    actions = Action.objects.exclude(user=request.user)
    work_actions = actions.exclude(type='common')
    actions = actions.exclude(type='work')    
    actions = actions.select_related('user', 'user__profile').prefetch_related('target')[:10]
    return render(request, 'account/notifications.html',
                  {'section': 'notifications', 'actions': actions, 'work_actions': work_actions})

@login_required
def professions(request):
    professions = Profession.objects.all()

    my_professions = []
    for profession in request.user.profile.rel_to_profession.all():
        if profession.confirmed:
            my_professions.append(profession.profession)

    return render(request, 'account/professions/professions.html',
                  {'section': 'professions',
                   'professions': professions,
                   'my_professions': my_professions})

@ajax_required
@require_POST
@login_required
def add_profession(request):
    profession_id = request.POST.get('id')
    action = request.POST.get('action')
    if profession_id and action:
        try:
            profession = Profession.objects.get(id=profession_id)
            if action == 'True':
                ProfileToProfession.objects.get_or_create(worker=request.user.profile,
                                                          profession=profession)
            else:
                messages.info(request, 'У вас уже указана эта профессия')
            return JsonResponse({'status':'ok'})
        except Profession.DoesNotExist:
            return JsonResponse({'status':'ok'})
    return JsonResponse({'status':'ok'})


def register(request):
    if request.method == 'POST':
        user_form = UserRegistrationForm(request.POST)
        if user_form.is_valid():
            # Создаем нового пользователя, но пока не сохраняем в базу данных.
            new_user = user_form.save(commit=False)
            # Задаем пользователю зашифрованный пароль.
            new_user.set_password(user_form.cleaned_data['password'])
            new_user.save()
            # Создание профиля и стандартной галереи пользователя.
            Profile.objects.create(user=new_user)
            Galary.objects.create(user=new_user, )
            #добавляем новость в ленту
            create_action(new_user, 'зарегистрировался')
            # Сохраняем пользователя в базе данных.
            new_user.save()
            return render(request,
                         'account/register_done.html',
                         {'new_user': new_user})
    else:
        user_form = UserRegistrationForm()
        return render(request,'account/register.html',{'user_form': user_form})

@login_required
def edit(request):
    if request.method == 'POST':
        user_form = UserEditForm(instance=request.user, data=request.POST)
        profile_form = ProfileEditForm(instance=request.user.profile,
                                       data=request.POST,
                                       files=request.FILES)
        if user_form.is_valid() and profile_form.is_valid():
            user_form.save()
            profile_form.save()
            messages.success(request, 'Данные успешно обновленны')
        else:
            messages.error(request, 'Ошибка в обновлении данных')
    else:
        user_form = UserEditForm(instance=request.user)
        profile_form = ProfileEditForm(instance=request.user.profile)
    return render(request, 'account/edit.html',
                  {'user_form': user_form,'profile_form': profile_form})

@login_required
def user_list(request):
    users = User.objects.filter(is_active=True)
    return render(request, 'account/user/list.html',
                  {'section': 'people', 'users': users})

@login_required
def user_detail(request, id):
    user = get_object_or_404(User, id=id, is_active=True)
    total_professions = 0
    for profession in user.profile.rel_to_profession.all():
        if profession.confirmed:
            total_professions += 1
    try:
        dialog_mbs = [user.profile, request.user.profile]
        dialog = Dialogs.objects.get(user_from__in=dialog_mbs, user_to__in=dialog_mbs).id
    except Dialogs.DoesNotExist:
        dialog = -1

    return image_list_mixin(request,
                            images_list=user.images_created.all(),
                            aj_temp='images/image/list_ajax.html',
                            tmp='account/user/detail.html',
                            section='people',
                            cont={'user': user,
                                  'total_professions': total_professions,
                                  'dialog': dialog})

@ajax_required
@require_POST
@login_required
def user_follow(request):
    user_id = request.POST.get('id')
    action = request.POST.get('action')
    if user_id and action:
        try:
            user = User.objects.get(id=user_id)
            if action == 'follow':
                Contact.objects.get_or_create(user_from=request.user, user_to=user)
                #добавляем новость в ленту
                create_action(request.user, 'подписался на', user)
            else:
                Contact.objects.filter(user_from=request.user, user_to=user).delete()
            return JsonResponse({'status':'ok'})
        except User.DoesNotExist:
            return JsonResponse({'status':'ok'})
    return JsonResponse({'status':'ok'})


@ajax_required
@require_POST
@login_required
def dialog_find(request):
    user_from = request.user
    user_id = request.POST.get('id')
    dialog_id = int(request.POST.get('dialog_id'))
    if user_id:
        try:
            user_to = User.objects.get(id=user_id)
        except User.DoesNotExist:
            return JsonResponse({'status':'UserDoesNotExist'})

    if dialog_id == -1:
        room = Room(title='dialog')
        room.save()
        room.members.add(user_from, user_to)
        dialog = Dialogs(user_from=user_from.profile, user_to=user_to.profile, room=room)
        dialog.save()
    else:
        try:
            dialog = Dialogs.objects.get(pk=dialog_id)
        except Dialogs.DoesNotExist:
            return JsonResponse({'status':'DialogDoesNotExist'})
    return JsonResponse({'url':'/chat/{}'.format(dialog.room.id)})
    # return redirect(reverse('chats:chat', kwargs={'room_id': dialog.room.id}))
