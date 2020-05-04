from django.shortcuts import render, get_object_or_404
from django.shortcuts import redirect
from django.conf import settings
import redis
from datetime import datetime

#from django.views.generic import View

from .models import Category, Product
from cart.forms import CartAddProductForm
from .recommender import Recommender

# Create your views here.
r = redis.StrictRedis(host=settings.REDIS_HOST,
					  port=settings.REDIS_PORT,
					  db=settings.REDIS_DB)

def shop(request, category_slug=None):
	category = None
	categories = Category.objects.all()
	products = Product.objects.filter(available=True)
	cart_product_form = CartAddProductForm()
	if category_slug:
		category = get_object_or_404(Category, slug=category_slug)
		cats = category.get_leafnodes(include_self=True)
		products = products.filter(
			category__in=[cat for cat in category.get_leafnodes(include_self=True)],
			available=True
			)
	return render(request, 'shops/shop/shop.html', context={
		'products_list': products,
		'category': category,
		'categories': categories,
		'cart_product_form': cart_product_form,
		})

def product_detail(request, id, slug):
	product = get_object_or_404(Product, id=id, slug=slug, available=True)
	cart_product_form = CartAddProductForm()
	recomm = Recommender()
	recommended_products = recomm.suggest_products_for([product], 4)
    #увеличение числа просмотров на 1
	total_views = r.incr('shops:{}:views'.format(product.id))
	r.set('shops:{}:{}'.format(product.id, request.user.id), ''.format(datetime.now()))
	#выпилил из render 'total_views': total_views}
	return render(request, 'shops/shop/product_detail.html',
				  context={'product': product,
				  		   'cart_product_form': cart_product_form,
						   'total_views': total_views,
						   'recommended_products': recommended_products})
