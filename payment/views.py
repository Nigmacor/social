import braintree
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse
from django.template.loader import render_to_string
import weasyprint

from orders.models import Order
from orders.utils import get_order_pdf
# Create your views here.

def payment_process(request):
    order_id = request.session.get('order_id')
    order = get_object_or_404(Order, id=order_id)
    if request.method=='POST':
        nonce = request.POST.get('payment_method_nonce', None)
        # Создание и сохранение транзакции
        result = braintree.Transaction.sale({
            'amount': '{:.2f}'.format(order.get_total_cost()),
            'payment_method_nonce': nonce,
            'options': {'submit_for_settlement': True}
        })
        if result.is_success:
            order.paid = True
            order.payment_id = result.transaction.id
            order.save()
            return redirect('payment:done')
        else:
            return redirect('payment:canceled')
    else:
        client_token = braintree.ClientToken.generate()
        return render(request,
                      'payment/process.html',
                      {'order': order, 'client_token': client_token})

# @users_own
def payment_done(request):
    if request.method == 'POST':
        order_id = request.session.get('order_id')
        order = get_object_or_404(Order, id=order_id)
        if request.user.id == order.user.id:
            return get_order_pdf(request, order_id)
    else:
        return render(request, 'payment/done.html')

def payment_canceled(request):
    return render(request, 'payment/canceled.html')
