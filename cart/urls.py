from django.urls import path
from .views import cart_detail, cart_add, remove

app_name = 'cart'
urlpatterns = [
    path('', cart_detail, name='cart_detail'),
    path('add/<product_id>/', cart_add, name='cart_add'),
    path('remove/<product_id>', remove, name='cart_remove'),
]
#path('add/<product_id>/', cart_add, name='cart_add'),
