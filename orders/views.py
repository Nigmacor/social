from django.urls import reverse
from django.shortcuts import render, redirect
from .models import OrderItem

from .forms import OrderCreateForm
from cart.cart import Cart
from .tasks import order_created

# Create your views here.

def order_create(request):
    cart = Cart(request)
    if request.method == 'POST':
        form = OrderCreateForm(request.POST)
        if form.is_valid():
            cd = form.cleaned_data
            order = form.save(commit=False)
            order.user = request.user
            order.save()
            for item in cart:
                OrderItem.objects.create(order=order,
                                         shop=item['product'].shop,
                                         product=item['product'],
                                         price=item['price'],
                                         quantity=item['quantity'])
            cart.clean()
            order_created.delay(order.id)
            # Сохраненяю заказ в сессии
            request.session['order_id'] = order.id
            return redirect(reverse('payment:process'))
    else:
        form = OrderCreateForm()
        return render(request,
                      'orders/order/create.html',
                      {'cart': cart, 'form': form})
