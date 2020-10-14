from django import template
from chat.models import Attach

register = template.Library()

@register.filter
def chat_attach_url(id):
    try:
        return Attach.objects.get(id=id).get_attach_url()

    except:
        return None
