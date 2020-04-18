from django.http import HttpResponse
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.shortcuts import render

def image_list_mixin(request, images_list, aj_temp, tmp, section, cont={}):
    images = images_list
    paginator = Paginator(images, 8)
    page = request.GET.get('page')
    try:
        images = paginator.page(page)
    except PageNotAnInteger:
        images = paginator.page(1)
    except EmptyPage:
        if request.is_ajax():
            return HttpResponse('')
        images = paginator.page(paginator.num_pages)
    if request.is_ajax():
        context = {'section': section, 'images': images}
        return render(request, aj_temp, dict(list(context.items()) + list(cont.items())))
    context = {'section': section, 'images': images}
    return render(request, tmp, dict(list(context.items()) + list(cont.items())))
