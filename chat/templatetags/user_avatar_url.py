from django import template
from django.contrib.auth.models import User

register = template.Library()

@register.filter
def user_avatar_url(id):
    try:
        user_img = User.objects.get(id=id).profile.photo.url
        return user_img
    except:
        return None
