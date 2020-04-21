from django.urls import path
from .views import shop, product_detail


urlpatterns = [
    path('', shop, name='shop'),
    path('<slug:category_slug>', shop, name='shop_by_category'),
    path('product/<str:id>/<slug:slug>', product_detail, name='product_detail_url'),

]
