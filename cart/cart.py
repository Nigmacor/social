from decimal import Decimal
from django.conf import settings

from coupons.models import Coupon
from shops.models import ServiceType

class Cart(object):

    def __init__(self, request):
        """инициализирую корзину"""
        
        self.session = request.session
        cart = self.session.get(settings.CART_SESSION_ID)
        if not cart:
            #создаю корзину, если ее нет
            cart = self.session[settings.CART_SESSION_ID] = {}

        # ids = self.session.get('product_ids')
        # print(request.session['product_ids'])
        # if not ids:
        #     request.session['product_ids'] = list()
        #     self.session = request.session
        self.cart = cart
        # Сохраняю купон.
        self.coupon_id = self.session.get('coupon_id')
        self.product_ids = list(self.cart.keys())

    def __len__(self):
        return sum(item['quantity'] for item in self.cart.values())

    def __iter__(self):
        ''' быть аккуратным с ним
        for product in products:
            self.cart[str(product.id)]['product'] = product
            self.cart[str(product.id)]['price'] = product.price
            self.cart[str(product.id)]['total_price'] = self.cart[str(product.id)]['price'] * self.cart[str(product.id)]['quantity']'''
        product_ids = self.cart.keys()
        products = ServiceType.objects.filter(id__in=product_ids)
        for product in products:
            self.cart[str(product.id)]['product'] = product
            


        for item in self.cart.values():
            item['price'] = Decimal(item['product'].get_type_obj().price)
            item['total_price'] = item['price'] * item['quantity']
            yield item


    def add(self, product, quantity=1, update_quantity=False):
        product_id = str(product.id)
        if product_id not in self.cart:
            self.cart[product_id] = {'quantity': 0,
                                      'price': str(product.get_type_obj().price)}
        if update_quantity:
            self.cart[product_id]['quantity'] = quantity
        else:
            self.cart[product_id]['quantity'] += quantity

        self.save()


    def remove(self, product):
        product_id = str(product.id)
        if product_id in self.cart:
            del self.cart[product_id]
        self.save()

    def save(self):
        self.session[settings.CART_SESSION_ID] = self.cart
        self.session.modified = True

    def get_total_price(self):
        return sum(Decimal(item['price']) * item['quantity'] for item in self.cart.values())

    def clean(self):
        del self.session[settings.CART_SESSION_ID]
        self.session.modified = True

    #определяю как свойство класса
    @property
    def coupon(self):
        if self.coupon_id:
            return Coupon.objects.get(id=self.coupon_id)
        return None

    def get_discount(self):
        if self.coupon:
            return (self.coupon.discount / Decimal('100')) * self.get_total_price()
        return Decimal('0')

    def get_total_price_after_discount(self):
        return self.get_total_price() - self.get_discount()
