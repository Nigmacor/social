from django.shortcuts import redirect, render, get_object_or_404
from django.conf import settings
from datetime import datetime
from django.contrib.auth.mixins import LoginRequiredMixin, PermissionRequiredMixin
from django.urls import reverse_lazy
from django.views.generic.list import ListView
from django.views.generic.edit import CreateView, UpdateView, DeleteView
from django.views.generic.base import TemplateResponseMixin, View
from django.forms.models import modelform_factory
from django.apps import apps
from django.http import Http404
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_POST
from django.db.models import Q
from django.contrib.postgres.search import TrigramSimilarity, SearchVector, SearchQuery, SearchRank
from django.db.models.functions import Greatest

import redis
from braces.views import JsonRequestResponseMixin
from common.decorators import ajax_required

from .models import Category, Shop, Product, Service, ProductContent, ServiceType, Slider, Slide, Wishlist

from cart.forms import CartAddProductForm
from .recommender import Recommender
from .forms import ProductFormSet, SearchForm
from comments.models import Comment
from comments.forms import CommentForm
from comments.views import CommentCreate
from .utils import service_type_filter
from management.models import Statistics

# Create your views here.
r = redis.StrictRedis(host=settings.REDIS_HOST,
					  port=settings.REDIS_PORT,
					  db=settings.REDIS_DB)

def shop(request, category_slug=None):
	category = None
	ancestors = None
	search_form = SearchForm()
	categories = Category.objects.filter(parent=None)
	products = ServiceType.objects.filter(available=True)
	cart_product_form = CartAddProductForm()
	slider = Slider.objects.filter(main=True).first()
	slides = Slide.objects.filter(slider=slider)
	if category_slug:
		category = get_object_or_404(Category, slug=category_slug)
		cats = category.get_descendants(include_self=True)
		ancestors = list(category.get_ancestors())[:-1]
		products = products.filter(
			Q(product__category__in=[cat for cat in cats]) |
			Q(service__category__in=[cat for cat in cats]))
		categories = category.get_leafnodes(include_self=False)

	return render(request, 'shops/shop/shop.html', context={
		'products_list': products,
		'category': category,
		'categories': categories,
		'cart_product_form': cart_product_form,
		'slider': slides,
		'ancestors': ancestors,
		'search_form': search_form,
		})

def product_search(request):
	search_form = SearchForm()
	query = None
	results = []
	if 'query' in request.GET:
		search_form = SearchForm(request.GET)
	if search_form.is_valid():
		query = search_form.cleaned_data['query']
		search =Greatest(
			TrigramSimilarity('product__title', query),
			TrigramSimilarity('service__title', query),
			TrigramSimilarity('product__short_description', query),
			TrigramSimilarity('service__short_description', query)
		)
		results = ServiceType.objects.annotate(
			similarity=search
			).filter(similarity__gt=0.2).filter(available=True).order_by('-similarity')
	return render(request, 'shops/shop/search.html', {'search_form': search_form,
													  'query': query,
													  'results': results})


def total_views_count(product):
	total_views = r.incr('products:{}:views'.format(product.id))
	return total_views


class ProductDetail(View):
	def get(self, request, id, slug):
		product = service_type_filter(id, slug)
		cart_product_form = CartAddProductForm()
		recomm = Recommender()
		recommended_products = recomm.suggest_products_for([product], 4)
		#увеличение числа просмотров на 1
		total_views = total_views_count(product)
		Statistics.objects.filter(product_or_service__product__slug=slug).update(views=total_views)
		r.set('products:{}:{}'.format(product.id, request.user.id), ''.format(datetime.now()))
		#выпилил из render 'total_views': total_views}

		context_product_detail = {'product': product.get_type_obj(),
								  'cart_product_form': cart_product_form,
								  'total_views': total_views,
								  'recommended_products': recommended_products,
								  'contents': product.contents.all()}

		context_comment = CommentCreate.get_comment(self, request, product)
		context_product_detail.update(context_comment)

		return render(request, 'shops/shop/product_detail.html',
					  context= context_product_detail)

	def post(self, request, slug, id):
		product = service_type_filter(id, slug)
		CommentCreate.post_comment(self, request, product)
		return redirect('product_detail_url', product.id, product.get_type_obj().slug)


def shop_detail(request, id):
	shop = get_object_or_404(Shop, id=id)
	return render(request,
				  'shops/shop/shop_detail.html',
				  {'shop': shop}
				  )

@ajax_required
@login_required
@require_POST
def wishlist_actions(request):
	product_id = request.POST.get('id')
	action = request.POST.get('action')
	if product_id and action:
		try:
			product = ServiceType.objects.get(id=product_id)
			wishlist = Wishlist.objects.get_or_create(owner=request.user)
			if action == 'add':
				print(wishlist)
				wishlist[0].products.add(product)
			else:
				print(wishlist)
				wishlist[0].products.remove(product)
			return JsonResponse({'status': 'ok'})
		except:
			pass
	return JsonResponse({'status': 'ok'})

@login_required
def wishlist(request):
	wishlist = Wishlist.objects.get_or_create(owner=request.user)
	cart_product_form = CartAddProductForm()
	return render(request, 'shops/shop/wishlist.html', {'wishlist': wishlist[0], 'cart_product_form': cart_product_form})

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

class ShopProductUpdateView(PermissionRequiredMixin, TemplateResponseMixin, View):
	permission_required = 'shops.change_product'
	template_name = 'shops/manage/product/formset.html'
	shop = None

	def get_formset(self, data=None):
		return ProductFormSet(instance=self.shop)

	#определяет HTTP-метод запроса и делегирует, либо get, либо post методу
	def dispatch(self, request, pk):
		self.shop = get_object_or_404(Shop, id=pk, employes=request.user)
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


class ContentCreateUpdateView(PermissionRequiredMixin, TemplateResponseMixin, View):
	permission_required = ['shops.change_productcontent', 'shops.add_productcontent']
	product = None
	model = None
	obj = None
	template_name = 'shops/manage/content/form.html'

	def get_model(self, model_name):
		if model_name in ['text', 'image', 'file']:
			return apps.get_model(app_label='shops', model_name=model_name)
		return None

	def get_form(self, model, *args, **kwargs):
		Form = modelform_factory(model, exclude=['publisher', 'created', 'updated', 'product'])
		return Form(*args, **kwargs)

	def dispatch(self, request, product_id, model_name, id=None):
		some_product = get_object_or_404(ServiceType, id=product_id)
		if request.user in some_product.get_type_obj().shop.employes.all():
			self.product = some_product
		else:
			raise Http404('У вас нет такого продукта')
		self.model = self.get_model(model_name)
		if id:
			some_object = get_object_or_404(self.model, id=id)
			if request.user in some_object.product.get_type_obj().shop.employes.all():
				self.obj = some_object
			else:
				raise Http404('У вас нет такой информации продукта')
		return super(ContentCreateUpdateView, self).dispatch(request, product_id, model_name, id)

	def get(self, request, product_id, model_name, id=None):
		form = self.get_form(self.model, instance=self.obj)
		return self.render_to_response({'form': form, 'object': self.obj, 'product': self.product.get_type_obj()})

	def post(self, request, product_id, model_name, id=None):
		form = self.get_form(self.model,
							 instance=self.obj,
							 data=request.POST,
							 files=request.FILES)
		if form.is_valid():
			obj = form.save(commit=False)
			obj.publisher = request.user
			obj.product = self.product
			obj.save()
			if not id:
				ProductContent.objects.create(product=self.product, item=obj)
			return redirect('product_content_list', self.product.id)
		return self.render_to_response({'form': form, 'object': self.obj})


class ContentDeleteView(PermissionRequiredMixin, View):
	permission_required = 'shops.delete_productcontent'
	def post(self, request, id):
		content = get_object_or_404(ProductContent, id=id)
		if request.user in content.product.get_type_obj().shop.employes.all():
			product = content.product
			content.item.delete()
			content.delete()
			return redirect('product_content_list', product.id)
		else:
			raise Http404('У вас нет такой информации продукта')


class ProductContentListView(TemplateResponseMixin, View):
	template_name = 'shops/manage/product/content_list.html'

	def get(self, request, product_id):
		product = get_object_or_404(ServiceType, id=product_id).get_type_obj()
		if request.user in product.shop.employes.all():
			return self.render_to_response({'product': product})
		else:
			raise Http404('У вас нет такого продукта')


class ContentOrderView(JsonRequestResponseMixin, View):
	def post(self, request):
		for id, order in self.request_json.items():
			print(self.request_json)
			obj = ProductContent.objects.filter(id=id).update(order=order)
		return self.render_json_response({'saved': 'OK'})

# доделать загрузчик контента
