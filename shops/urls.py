from django.urls import path
from .views import shop, product_detail, shop_detail


urlpatterns = [
    path('', shop, name='shop'),
    path('<slug:category_slug>', shop, name='shop_by_category'),
    path('product/<str:id>/<slug:slug>', product_detail, name='product_detail_url'),
    path('shop/<str:id>/', shop_detail, name='shop_detail_url'),

]
