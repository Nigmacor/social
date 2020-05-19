from django.urls import path
from .views import *


urlpatterns = [
    path('', shop, name='shop'),
    path('<slug:category_slug>', shop, name='shop_by_category'),
    path('shop/mine/', ManageShopListView.as_view(), name='manage_shop_list'),
    path('shop/create/', ShopCreateViev.as_view(), name='shop_create'),
    path('shop/<pk>/edit', ShopUpdateViev.as_view(), name='shop_edit'),
    path('shop/<pk>/delete', ShopDeleteView.as_view(), name='shop_delete'),
    path('shop/<pk>/products_edit/', ShopProductUpdateView.as_view(), name='shop_product_update'),
    path('product/<int:product_id>/content/<model_name>/create/',
         ContentCreateUpdateView.as_view(),
         name='product_content_create'),
    path('product/<int:product_id>/content/<model_name>/<id>/',
         ContentCreateUpdateView.as_view(),
         name='product_content_update'),
    path('shop/<str:id>/', shop_detail, name='shop_detail_url'),
    path('product/<str:id>/<slug:slug>', product_detail, name='product_detail_url'),
    path('content/<int:id>/delete/', ContentDeleteView.as_view(), name='product_content_delete'),
    path('product/<int:product_id>/', ProductContentListView.as_view(), name='product_content_list'),

]
