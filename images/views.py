from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_POST
from django.contrib import messages
from django.http import JsonResponse
import redis
from django.conf import settings

from common.decorators import ajax_required
from common.mixin import image_list_mixin
from actions.utils import create_action

from .forms import ImageCreateForm
from .models import Image

# Create your views here.
#Подключаю redis
# r = redis.StrictRedis(host=settings.REDIS_HOST,
#                       port=settings.REDIS_PORT,
#                       db=settings.REDIS_DB)

@login_required
def image_create(request):
    if request.method == 'POST':
        form = ImageCreateForm(request.POST)
        if form.is_valid():
            cd = form.cleaned_data
            new_item = form.save(commit=False)
            new_item.user = request.user
            new_item.save()
            #добавляем новость в ленту
            create_action(request.user, 'добавленно изображение', new_item)
            messages.success(request, 'Изображение успешно добавленно')
            return redirect(new_item)
    else:
        form = ImageCreateForm(data=request.GET)
    return render(request, 'images/image/create.html',
                  {'section': 'images', 'form': form})

def image_detail(request, id, slug):
    image = get_object_or_404(Image, id=id, slug=slug)
    #увеличение числа просмотров на 1
    # total_views = r.incr('image:{}:views'.format(image.id))
    #увеличение рейтинга картинки на 1
    # r.zincrby('image_ranking', 1, image.id)
    #выпилил из render 'total_views':total_views
    return render(request, 'images/image/detail.html',
                  {'section': 'images', 'image': image})

# @login_required
# def image_ranking(request):
#     # Получение набора рейтингов картинок.
#     image_ranking = r.zrange('image_ranking', 0, -1, desc=True)[:10]
#     image_ranking_ids = [int(id) for id in image_ranking]
#     # Получение отсортированного списока самых популярных картинок.
#     # list() использую, чтоб юзать sort()
#     most_viewed = list(Image.objects.filter(id__in=image_ranking_ids))
#     most_viewed.sort(key=lambda x: image_ranking_ids.index(x.id))
#     return render(request,'images/image/ranking.html',
#                   {'section': 'images', 'most_viewed': most_viewed})

@ajax_required
@login_required
@require_POST
def image_like(request):
    image_id = request.POST.get('id')
    action = request.POST.get('action')
    if image_id and action:
        try:
            image = Image.objects.get(id=image_id)
            if action == 'like':
                image.users_like.add(request.user)
                #добавляем новость в ленту
                create_action(request.user, 'понравилось', image)
            else:
                image.users_like.remove(request.user)
            return JsonResponse({'status': 'ok'})
        except:
            pass
    return JsonResponse({'status': 'ok'})

@login_required
def image_list(request):
    images = Image.objects.all()
    return image_list_mixin(request,
                            images_list=images,
                            aj_temp='images/image/list_ajax.html',
                            tmp='images/image/list.html',
                            section='images')



# def image_list(request):
#     images = Image.objects.all()
#     paginator = Paginator(images, 8)
#     page = request.GET.get('page')
#     try:
#         images = paginator.page(page)
#     except PageNotAnInteger:
#         images = paginator.page(1)
#     except EmptyPage:
#         if request.is_ajax():
#             return HttpResponse('')
#         images = paginator.page(paginator.num_pages)
#     if request.is_ajax():
#         return render(request,'images/image/list_ajax.html',
#                       {'section': 'images', 'images': images})
#     return render(request,'images/image/list.html',
#                   {'section': 'images', 'images': images})
