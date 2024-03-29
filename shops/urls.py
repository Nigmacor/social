from django.urls import path
from .views import *
from comments.views import CommentDelete, CommentUpdate, ReplyCreate, ReplyDelete, ComplaintCommentCreate, ComplaintReplyCreate


urlpatterns = [
    path('', shop, name='shop'),
    path('<slug:category_slug>', shop, name='shop_by_category'),
    path('shop/mine/', ManageShopListView.as_view(), name='manage_shop_list'),
    path('shop/create/', ShopCreateViev.as_view(), name='shop_create'),
    path('shop/<pk>/edit', ShopUpdateViev.as_view(), name='shop_edit'),
    path('shop/<pk>/delete', ShopDeleteView.as_view(), name='shop_delete'),
    path('shop/<pk>/products_edit/', ShopProductUpdateView.as_view(), name='shop_product_update'),
    path('shop/<str:id>/detail/', shop_detail, name='shop_detail_url'),
    path('product/<int:product_id>/content/<model_name>/create/',
         ContentCreateUpdateView.as_view(),
         name='product_content_create'),
    path('product/<int:product_id>/content/<model_name>/<id>/',
         ContentCreateUpdateView.as_view(),
         name='product_content_update'),
    path('product/<str:id>/<slug:slug>', ProductDetail.as_view(), name='product_detail_url'),
    path('content/<int:id>/delete/', ContentDeleteView.as_view(), name='product_content_delete'),
    path('content/order/', ContentOrderView.as_view(), name='content_order'),
    path('product/<int:product_id>/', ProductContentListView.as_view(), name='product_content_list'),
    path('wishlist/', wishlist, name='wishlist'),
    path('wishlist/action/', wishlist_actions, name='wishlist_actions'),
    path('product/update_comment/<str:id_p>/<str:id>', CommentUpdate.as_view(), name='comment_update_url'),
    path('product/delete_comment/<str:id_p>/<str:id>', CommentDelete.as_view(), name='comment_delete_url'),
    path('product/reply/<str:id_p>/<str:id>', ReplyCreate.as_view(), name='reply_url'),
    path('product/delete_reply/<str:id_p>/<str:id>', ReplyDelete.as_view(), name='reply_delete_url'),
    path('product/comment/<str:id_p>/<str:id>/complaint', ComplaintCommentCreate.as_view(), name='complaint_comment_url'),
    path('product/reply/<str:id_c>/<str:id>/complaint', ComplaintReplyCreate.as_view(), name='complaint_reply_url'),
    path('search/', product_search, name='search'),
]
