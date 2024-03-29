from django import forms
from urllib import request
from django.core.files.base import ContentFile
from django.utils.text import slugify
from .models import Image

class ImageCreateForm(forms.ModelForm):
    def clean_url(self):
        url = self.cleaned_data['url']
        valid_extentions = ['jpg', 'jpeg']
        extention = url.rsplit('.', 1)[1].lower()
        if extention not in valid_extentions:
            raise forms.ValidationError('Неверный URL или не подходящее ' \
                                        'разрешение изображения .')
        return url
    def save(self, force_insert=False, force_update=False, commit=True):
        image = super(ImageCreateForm, self).save(commit=False)
        image_url = self.cleaned_data['url']
        image_name = '{}.{}'.format(slugify(image.title),
                                    image_url.rsplit('.', 1)[1].lower())
        #Cкaчиваниe изoбpажeния по укaзaннoму aдрecу.
        response = request.urlopen(image_url)
        image.image.save(image_name, ContentFile(response.read()), save=False)
        if commit:
            image.save()
        return image

    class Meta:
        model = Image
        fields = ('title', 'url', 'description')
        widgets = {'url': forms.HiddenInput}
