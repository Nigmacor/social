from django.http import Http404
from django.db.models import Q
from .models import ServiceType


def service_type_filter(id, slug):
    product = ServiceType.objects.filter(
        Q(id=id, product__slug=slug, product__available=True) |
        Q(id=id, service__slug=slug, service__available=True))
    if not product:
        raise Http404('К сожалению данный продукт недоступен')
    else:
        product = product.first()
    return product
