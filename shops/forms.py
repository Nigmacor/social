from django import forms
from django.forms.models import inlineformset_factory

from .models import Shop, Product, ServiceType


ProductFormSet = inlineformset_factory(Shop,
                                       Product,
                                       fields=['category', 'title', 'available', 'price'],
                                       extra=0,
                                       can_delete=True)

class SearchForm(forms.Form):
    query = forms.CharField(label='',
                            widget=forms.TextInput(
                                attrs={
                                    'placeholder': 'Я хочу найти...',
                                    'id': 'search-input',
                                    'type': 'text'
                                }))
