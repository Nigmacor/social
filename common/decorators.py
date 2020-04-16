from django.http import HttpResponseBadRequest

def ajax_required(f):
    #возвращает объект код ошибки 400 если запрос не ajax
    def wrap(request, *args, **kwargs):
        if not request.is_ajax():
            return HttpResponseBadRequest()
        return f(request, *args, **kwargs)
    wrap.__doc__ = f.__doc__
    wrap.__name__ = f.__name__
    return wrap
