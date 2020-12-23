from .models import Statistics


def overall_county_and_price_in_shop(products):
    overall_price_in_shop=0
    overall_county_in_shop=0
    for product in products:
        if product.product_or_service.define_type() == 'Продукт':
            price=product.product_or_service.product.price
            county=product.product_or_service.product.county
            overall_price_of_products=county*price
            overall_price_in_shop+=overall_price_of_products
            overall_county_in_shop+=county

    return overall_price_in_shop, overall_county_in_shop

def overall_county_and_price(shops):
    overall_price=0
    overall_county=0
    for shop in shops:
        products = Statistics.objects.filter(st_shop=shop)
        overall_price_in_shop, overall_county_in_shop = overall_county_and_price_in_shop(products)
        overall_price+=overall_price_in_shop
        overall_county+=overall_county_in_shop
    return overall_price, overall_county
