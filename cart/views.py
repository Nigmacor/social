from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.http import require_POST
from django.http import JsonResponse

from shops.models import ServiceType
from shops.recommender import Recommender
from .cart import Cart
from .forms import CartAddProductForm
from coupons.forms import CouponApplyForm

# Create your views here.
@require_POST
def cart_add(request, product_id):
    cart = Cart(request)
    product = get_object_or_404(ServiceType, id=product_id)
    form = CartAddProductForm(request.POST)
    if form.is_valid():
        cd = form.cleaned_data
        cart.add(product=product, quantity=cd['quantity'], update_quantity=cd['update'])
    #заглушка

    return redirect('cart:cart_detail')
    #return JsonResponse(slov)

"""@require_POST
def cart_add(request, product_id):
    cart = Cart(request)
    product = get_object_or_404(Product, id=product_id)
    form = CartAddProductForm(request.POST)
    print(product_id)
    if form.is_valid():
        cd = form.cleaned_data
        cart.add(product=product, quantity=cd['quantity'], update_quantity=cd['update'])
    #заглушка

    return redirect('cart:cart_detail')"""


def remove(request, product_id):
    cart = Cart(request)
    product = get_object_or_404(ServiceType, id=product_id)
    cart.remove(product)
    return redirect('cart:cart_detail')

def cart_detail(request):
    cart = Cart(request)
    for item in cart:
        item['update_quantity_form'] = CartAddProductForm(
                                        initial={'quantity': item['quantity'],
                                        'update': True}, auto_id=False)
    coupon_apply_form = CouponApplyForm()
    rec = Recommender()    
    cart_products = [item['product'] for item in cart]
    recommended_products = rec.suggest_products_for(cart_products, max_result=4)
    return render(request, 'cart/cart_detail.html',
                  {'cart': cart,
                   'coupon_apply_form': coupon_apply_form,
                   'recommended_products': recommended_products,})
