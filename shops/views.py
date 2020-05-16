from django.shortcuts import redirect, render, get_object_or_404
from django.conf import settings
import redis
from datetime import datetime
from django.contrib.auth.mixins import LoginRequiredMixin, PermissionRequiredMixin
from django.urls import reverse_lazy
from django.views.generic.list import ListView
from django.views.generic.edit import CreateView, UpdateView, DeleteView
from django.views.generic.base import TemplateResponseMixin, View

#from django.views.generic import View

from .models import Category, Shop, Product
from cart.forms import CartAddProductForm
from .recommender import Recommender
from .forms import ProductFormSet

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
	total_views = r.incr('products:{}:views'.format(product.id))
	r.set('products:{}:{}'.format(product.id, request.user.id), ''.format(datetime.now()))
	#выпилил из render 'total_views': total_views}
	return render(request, 'shops/shop/product_detail.html',
				  context={'product': product,
				  		   'cart_product_form': cart_product_form,
						   'total_views': total_views,
						   'recommended_products': recommended_products})

def shop_detail(request, id):
	shop = get_object_or_404(Shop, id=id)
	return render(request,
				  'shops/shop/shop_detail.html',
				  {'shop': shop}
				  )


class OwnerMixin(object):
    def get_queryset(self):
        qs = super(OwnerMixin, self).get_queryset()
        return qs.filter(owner=self.request.user)

class OwnerEditMixin(object):
    def form_valid(self, form):
        form.instance.owner = self.request.user
        return super(OwnerEditMixin, self).form_valid(form)

class OwnerShopMixin(OwnerMixin, LoginRequiredMixin):
    model = Shop
    fields = ['name', 'slug', 'contact_email', 'contact_phone', 'template_prefix']
    success_url = reverse_lazy('manage_shop_list')

class OwnerShopEditMixin(OwnerShopMixin, OwnerEditMixin):
    fields = ['name', 'slug', 'title', 'contact_email', 'contact_phone', 'template_prefix']
    success_url = reverse_lazy('manage_shop_list')
    template_name = 'shops/manage/shop/form.html'

class ManageShopListView(OwnerShopMixin, ListView):
    template_name = 'shops/manage/shop/list.html'

class ShopCreateViev(PermissionRequiredMixin, OwnerShopEditMixin, CreateView):
    permission_required = 'shops.add_shop'

class ShopUpdateViev(PermissionRequiredMixin, OwnerShopEditMixin, UpdateView):
    permission_required = 'shops.change_shop'

class ShopDeleteView(PermissionRequiredMixin, OwnerShopMixin, DeleteView):
    permission_required = 'shops.delete_shop'
    template_name = 'shops/manage/shop/delete.html'
    success_url = reverse_lazy('manage_shop_list')

class ShopProductUpdateView(TemplateResponseMixin, View):
	template_name = 'shops/manage/product/formset.html'
	shop = None

	def get_formset(self, data=None):
		return ProductFormSet(instance=self.shop)

	#определяет HTTP-метод запроса и делегирует, либо get, либо post методу
	def dispatch(self, request, pk):
		self.shop = get_object_or_404(Shop, id=pk, owner=request.user)
		return super(ShopProductUpdateView, self).dispatch(request, pk)

	def get(self, request, *args, **kwargs):
		formset = self.get_formset()
		return self.render_to_response({'shop': self.shop, 'formset': formset})

	def post(self, request, *args, **kwargs):
		formset = self.get_formset(request.POST)
		if formset.is_valid():
			formset.save()
			return redirect('manage_shop_list')
		return self.render_to_response({'shop': self.shop, 'formset': formset})
