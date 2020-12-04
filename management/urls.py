from django.urls import path
from .views import *

from management.views import Statistic, Shop_info, Shop_stat, Prod_info, Prod_stat, Comments_info

urlpatterns = [
    path('', Manage.as_view(), name='manage_url'),
    path('statistics/', Statistic.as_view(), name='statistics_url'),
    path('shop_info/<str:id>/', Shop_info.as_view(), name='shop_info_url'),
    path('shop_stat/<str:id>/', Shop_stat.as_view(), name='shop_stat_url'),
    path('prod_info/<str:id>/', Prod_info.as_view(), name='prod_info_url'),
    path('prod_stat/<str:id>/', Prod_stat.as_view(), name='prod_stat_url'),
    path('comments_info/<str:id>/', Comments_info.as_view(), name='comments_stat_url')
]
