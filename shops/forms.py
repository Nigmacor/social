from django import forms
from django.forms.models import inlineformset_factory

from .models import Shop, Product


ProductFormSet = inlineformset_factory(Shop,
                                       Product,
                                       fields=['category', 'title', 'available', 'price'],
                                       extra=0,
                                       can_delete=True)
