from decimal import Decimal
from django.conf import settings
from shops.models import Product

class Cart(object):

    def __init__(self, request):
        """инициализирую корзину"""
        self.session = request.session
        cart = self.session.get(settings.CART_SESSION_ID)
        if not cart:
            #создаю корзину, если ее нет
            cart = self.session[settings.CART_SESSION_ID] = {}
        self.cart = cart

    def __len__(self):
        return sum(item['quantity'] for item in self.cart.values())

    def __iter__(self):
        ''' быть аккуратным с ним
        for product in products:
            self.cart[str(product.id)]['product'] = product
            self.cart[str(product.id)]['price'] = product.price
            self.cart[str(product.id)]['total_price'] = self.cart[str(product.id)]['price'] * self.cart[str(product.id)]['quantity']'''
        product_ids = self.cart.keys()
        products = Product.objects.filter(id__in=product_ids)
        for product in products:
            self.cart[str(product.id)]['product'] = product

        for item in self.cart.values():
            item['price'] = Decimal(item['product'].price)
            item['total_price'] = item['price'] * item['quantity']
            yield item


    def add(self, product, quantity=1, update_quantity=False):
        product_id = str(product.id)
        if product_id in self.cart:
            self.cart[product_id]['quantity'] += quantity
            update_quantity=False
        else:
            self.cart[product_id] = {'quantity': 0}

        if update_quantity:
            self.cart[product_id]['quantity'] = quantity
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
        return sum(Decimal(item['total_price']) for item in self.cart.values())

    def clean(self):
        del self.session[settings.CART_SESSION_ID]
        self.session.modified = True
