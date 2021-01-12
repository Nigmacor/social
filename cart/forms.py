from django import forms

PRODUCT_QUANTITY_CHOICES = [(i, str(i)) for i in range(1, 11)]

class CartAddProductForm(forms.Form):
    quantity = forms.TypedChoiceField(choices=PRODUCT_QUANTITY_CHOICES, coerce=int, label='',
                                      widget=forms.widgets.Select(
                                          attrs={'class': 'quantitySelect form-control',}))
    update = forms.BooleanField(required=False, initial=True, widget=forms.HiddenInput)
    # product_id = forms.CharField(widget=forms.HiddenInput)
    # product_id = forms.CharField(widget=forms.widgets.Input(attrs={'type':'hidden', 'value':'{{ product.id }}'}))
    # #forms.CharField(widget=forms.HiddenInput)
