from django import forms

from .models import TypeOfWork, Project


types_of_work = TypeOfWork.objects.all()
PRODUCT_QUANTITY_CHOICES = [(type.id, str(type.title)) for type in types_of_work]

class ProjectCreateForm(forms.Form):
    type = forms.TypedChoiceField(choices=PRODUCT_QUANTITY_CHOICES, coerce=int, label='')
    title = forms.CharField()
    description = forms.CharField(widget=forms.Textarea)
    # product_id = forms.CharField(widget=forms.HiddenInput)
    # product_id = forms.CharField(widget=forms.widgets.Input(attrs={'type':'hidden', 'value':'{{ product.id }}'}))
    # #forms.CharField(widget=forms.HiddenInput)
