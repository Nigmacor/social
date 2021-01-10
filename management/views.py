import json
from django.shortcuts import render
from django.views.generic.base import View
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.paginator import Paginator
from django.db.models import Q
from datetime import datetime, date, timedelta

from .models import Statistics, Statistics_shop
from orders.models import OrderItem
from shops.models import Shop, ServiceType
from comments.models import Comment
from comments.views import paginate_comments
from .utils import overall_county_and_price_in_shop, overall_county_and_price, add_empty_views

# Create your views here.
class Manage(LoginRequiredMixin, View):
    def get(self, request):
        shops_origin = Shop.objects.filter(employes=request.user)

        for shop_or in shops_origin:
            Statistics_shop.objects.update_or_create(shop=shop_or)
            shop = Statistics_shop.objects.get(shop=shop_or)
            for product_or in shop_or.product.all():
                Statistics.objects.update_or_create(product_or_service=product_or.service_type, st_shop=shop, type='Продукт')
            for service_or in shop_or.service.all():
                Statistics.objects.update_or_create(product_or_service=service_or.service_type, st_shop=shop, type='Услуга')

        shops = Statistics_shop.objects.filter(shop__employes=request.user)

        for shop in shops:
            products_in_shop = Statistics.objects.filter(st_shop=shop)
            quantity_in_shop=0
            total_cost_in_shop=0
            paid_quantity_in_shop=0
            paid_total_cost_in_shop=0
            views_in_shop=0
            comments_in_shop=0
            in_cart_in_shop=0
            quantity_of_products_and_services=0
            sum_rating=0
            rating_in_shop=0

            for product in products_in_shop:
                quantity_in_shop+=product.orders
                total_cost_in_shop+=product.orders_cost
                paid_quantity_in_shop+=product.paid_orders
                paid_total_cost_in_shop+=product.paid_orders_cost
                views_in_shop+=product.views
                comments_in_shop+=product.amount_of_comments
                in_cart_in_shop+=product.in_cart
                quantity_of_products_and_services+=1
                sum_rating+=product.rating

                quantity=0
                total_cost=0
                paid_quantity=0
                paid_total_cost=0
                orders = OrderItem.objects.filter(product=product.product_or_service)
                for order in orders:
                    this_quantity=order.quantity
                    quantity+=this_quantity
                    this_cost=order.get_cost()
                    total_cost=total_cost+this_cost

                    if order.order.paid == True:
                        paid_this_quantity=order.quantity
                        paid_quantity+=paid_this_quantity
                        paid_this_cost=order.get_cost()
                        paid_total_cost=paid_total_cost+paid_this_cost

                Statistics.objects.filter(product_or_service=product.product_or_service).update(orders=quantity,
                                                                                                orders_cost=total_cost,
                                                                                                paid_orders=paid_quantity,
                                                                                                paid_orders_cost=paid_total_cost,
                                                                                                )

            if quantity_of_products_and_services != 0:
                rating_in_shop=sum_rating/quantity_of_products_and_services

            Statistics_shop.objects.filter(shop=shop.shop).update(orders=quantity_in_shop,
                                                                  orders_cost=total_cost_in_shop,
                                                                  paid_orders=paid_quantity_in_shop,
                                                                  paid_orders_cost=paid_total_cost_in_shop,
                                                                  views=views_in_shop,
                                                                  amount_of_comments=comments_in_shop,
                                                                  in_cart=in_cart_in_shop,
                                                                  quantity_of_products_and_services=quantity_of_products_and_services,
                                                                  rating=rating_in_shop,
                                                                  )
        return render(request, 'management/manage.html',
					  context={'shops': shops,
                               })

    def post(self, request, id):
        return render(request, 'management/manage.html')


class Statistic(LoginRequiredMixin, View):
    def get(self, request):
        shops = Statistics_shop.objects.filter(shop__employes=request.user)
        overall_price, overall_county = overall_county_and_price(shops)
        return render(request, 'management/statistics.html',
					  context={'shops': shops,
                               'overall_price': overall_price,
                               'overall_county': overall_county,
                               })

    def post(self, request):
        return render(request, 'management/statistics.html',
					  context={'products': products,
                               })


class Shop_info(LoginRequiredMixin, View):
    def get(self, request, id):
        shop = Statistics_shop.objects.get(id=id)
        return render(request, 'management/shop_info.html',
					  context={'shop': shop,
                               })

    def post(self, request):
        return


class Shop_stat(LoginRequiredMixin, View):
    def get(self, request, id):
        shop = Statistics_shop.objects.get(id=id)
        products = Statistics.objects.filter(st_shop=shop)

        # В идеале сделать сортировку по заказам, цене и т.д.
        bestsellers_orders=-1
        bestseller=None
        leastseller_orders=9999999
        leastseller=None
        for product in products:
            if product.paid_orders>bestsellers_orders:
                bestsellers_orders=product.paid_orders
                bestseller=product
            if product.paid_orders<leastseller_orders:
                leastseller_orders=product.paid_orders
                leastseller=product

        overall_price, overall_county = overall_county_and_price_in_shop(products)
        return render(request, 'management/shop_stat.html',
					  context={'shop': shop,
                               'products': products,
                               'bestseller': bestseller,
                               'leastseller': leastseller,
                               'overall_price': overall_price,
                               'overall_county': overall_county,
                               })

    def post(self, request):
        return


class Prod_info(LoginRequiredMixin, View):
    def get(self, request, id):
        pr_or_serv = Statistics.objects.get(id=id)
        return render(request, 'management/prod_info.html',
					  context={'product': pr_or_serv,
                               })

    def post(self, request, id):
        return


class Prod_stat(LoginRequiredMixin, View):
    def get(self, request, id):
        pr_or_serv = Statistics.objects.get(id=id)
        overall_price = 0
        if pr_or_serv.product_or_service.define_type() == 'Продукт':
            overall_price=pr_or_serv.product_or_service.product.price*pr_or_serv.product_or_service.product.county
        return render(request, 'management/prod_stat.html',
					  context={'product': pr_or_serv,
                               'overall_price': overall_price,
                               })

    def post(self, request, id):
        return


class Prod_stat_daily(LoginRequiredMixin, View):
    def get(self, request, id):
        pr_or_serv = Statistics.objects.get(id=id)
        dict_views_per_day = json.loads(pr_or_serv.views_per_day)
        today = date.today()
        str_today = today.strftime("%d/%m/%Y")
        if str_today not in dict_views_per_day.keys():
            dict_views_per_day = add_empty_views(str_today, dict_views_per_day)
        views_per_day = dict_views_per_day.items()

        orderitems = OrderItem.objects.filter(product=pr_or_serv.product_or_service)
        orders_per_day = {}
        paid_orders_per_day = {}
        quantity = 0
        paid_quantity = 0
        days = [0]
        paid_days = [0]
        for orderitem in orderitems:
            day = orderitem.order.created
            str_day = day.strftime("%d/%m/%Y")
            this_quantity = orderitem.quantity
            if str_day == days[-1]:
                quantity += this_quantity
                orders_per_day.update({str_day: quantity})
            else:
                quantity = this_quantity
                orders_per_day.update({str_day: this_quantity})
            if orderitem.order.paid == True:
                paid_this_quantity = orderitem.quantity
                paid_day = orderitem.order.created
                if str_day == paid_days[-1]:
                    paid_quantity += paid_this_quantity
                    paid_orders_per_day.update({str_day: paid_quantity})
                else:
                    paid_quantity = paid_this_quantity
                    paid_orders_per_day.update({str_day: paid_this_quantity})
                paid_days.append(str_day)
            days.append(str_day)
        orders_per_day = orders_per_day.items()
        paid_orders_per_day = paid_orders_per_day.items()

        dates = {}
        for key, value in views_per_day:
            value_list = [value, 0, 0]
            for key2, value2 in orders_per_day:
                if key2 == key:
                    value_list = [value, value2, 0]
                    for key3, value3 in paid_orders_per_day:
                        if key3 == key2:
                            value_list = [value, value2, value3]
                else:
                    for key3, value3 in paid_orders_per_day:
                        if key3 == key:
                            value_list = [value, 0, value3]
            dates.update({key: value_list})
        dates = dates.items()
        return render(request, 'management/prod_stat_daily.html',
					  context={'product': pr_or_serv,
                               'views_per_day': views_per_day,
                               'orders_per_day': orders_per_day,
                               'paid_orders_per_day': paid_orders_per_day,
                               'dates': dates,
                               })

    def post(self, request, id):
        return


class Comments_info(LoginRequiredMixin, View):
    def get(self, request, id):
        product = Statistics.objects.get(id=id)
        comments_objects = Comment.objects.filter(product_or_service=product.product_or_service).order_by('-date')
        page, is_paginated, next_url, prev_url = paginate_comments(request, comments_objects)
        return render(request, 'management/comments_info.html',
					  context={'product': product,
                               'page_object': page,
                       		   'is_paginated': is_paginated,
                       		   'next_url': next_url,
                       	       'prev_url': prev_url,
                               })

    def post(self, request):
        return
