from django.urls import path
from .views import *


urlpatterns = [
    path('', shop, name='shop'),
    path('<slug:category_slug>', shop, name='shop_by_category'),
    path('product/<str:id>/<slug:slug>', product_detail, name='product_detail_url'),
    path('shop/mine/', ManageShopListView.as_view(), name='manage_shop_list'),
    path('shop/create/', ShopCreateViev.as_view(), name='shop_create'),
    path('shop/<pk>/edit', ShopUpdateViev.as_view(), name='shop_edit'),
    path('shop/<pk>/delete', ShopDeleteView.as_view(), name='shop_delete'),
    path('shop/<str:id>/', shop_detail, name='shop_detail_url'),

]
