from django.shortcuts import render
from django.views.generic.base import View
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.paginator import Paginator

from .models import Statistics, Statistics_shop
from orders.models import OrderItem
from shops.models import Shop, ServiceType
from comments.models import Comment
from comments.views import paginate_comments

# Create your views here.
def overall_county_and_price_in_shop(products):
    overall_price_in_shop=0
    overall_county_in_shop=0
    for product in products:
        price=product.product_or_service.product.price
        county=product.product_or_service.product.county
        overall_price_of_products=county*price
        overall_price_in_shop+=overall_price_of_products
        overall_county_in_shop+=county
    return overall_price_in_shop, overall_county_in_shop

def overall_county_and_price(shops):
    # overall_price=0
    # overall_price_of_products=0
    # overall_price_in_shop = 0
    # overall_county=0
    # overall_county_in_shop=0
    # for shop in shops:
    #     for product in products:
    #         price=product.product_or_service.product.price
    #         overall_price_of_products=county*price
    #         overall_price_in_shop+=overall_price_of_products
    #         county=product.product_or_service.product.county
    #         overall_county_in_shop+=county
    #     overall_price+=overall_price_in_shop
    #     overall_county+=overall_county_in_shop
    # return overall_price, overall_county

    overall_price=0
    overall_county=0
    for shop in shops:
        products = Statistics.objects.filter(st_shop=shop)
        overall_price_in_shop, overall_county_in_shop = overall_county_and_price_in_shop(products)
        overall_price+=overall_price_in_shop
        overall_county+=overall_county_in_shop
    return overall_price, overall_county


class Manage(LoginRequiredMixin, View):
    def get(self, request):
        products = Statistics.objects.filter(product_or_service__product__shop__employes=request.user)
        shops = Statistics_shop.objects.filter(shop__employes=request.user)
        shops_origin = Shop.objects.filter(employes=request.user)
        products_origin = ServiceType.objects.filter(product__shop__employes=request.user)

        for shop_or in shops_origin:
            Statistics_shop.objects.update_or_create(shop=shop_or)
        for product_or in products_origin:
            shop=Statistics_shop.objects.get(shop=product_or.product.shop)
            Statistics.objects.update_or_create(product_or_service=product_or, st_shop=shop)

        for product in products:
            quantity=0
            total_cost=0
            paid_quantity=0
            paid_total_cost=0
            orders = OrderItem.objects.filter(product=product.product_or_service)

            for order in orders:
                this_quantity = order.quantity
                quantity=quantity+this_quantity
                this_cost = order.get_cost()
                total_cost= total_cost+this_cost

                if order.order.paid == True:
                    paid_this_quantity = order.quantity
                    paid_quantity=paid_quantity+paid_this_quantity
                    paid_this_cost = order.get_cost()
                    paid_total_cost= paid_total_cost+paid_this_cost

            Statistics.objects.filter(product_or_service=product.product_or_service).update(orders=quantity,
                                                                                            orders_cost=total_cost,
                                                                                            paid_orders=paid_quantity,
                                                                                            paid_orders_cost=paid_total_cost,
                                                                                            )

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
                               'products': products,
                               })

    def post(self, request, id):
        return render(request, 'management/manage.html')


class Statistic(LoginRequiredMixin, View):
    def get(self, request):
        products = Statistics.objects.filter(product_or_service__product__shop__employes=request.user)
        shops = Statistics_shop.objects.filter(shop__employes=request.user)
        # products = Statistics.objects.filter(st_shop=shop)
        overall_price, overall_county = overall_county_and_price(shops)
        return render(request, 'management/statistics.html',
					  context={'products': products,
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
        bestsellers_orders=0
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
        product = Statistics.objects.get(id=id)
        return render(request, 'management/prod_info.html',
					  context={'product': product,
                               })

    def post(self, request, id):
        return


class Prod_stat(LoginRequiredMixin, View):
    def get(self, request, id):
        product = Statistics.objects.get(id=id)
        # определить услуга или товар

        overall_price=product.product_or_service.product.price*product.product_or_service.product.county
        return render(request, 'management/prod_stat.html',
					  context={'product': product,
                               'overall_price': overall_price,
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
