from django import forms
from django.core.exceptions import ValidationError

from .models import Comment, Reply, ImageComment

class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = ['rating', 'text']
        CHOICES = (('1', '1'), ('2', '2'), ('3', '3'), ('4', '4'), ('5', '5'))

        widgets = {
            'rating': forms.Select(choices=CHOICES, attrs={'class': 'd-none'}),
            'text': forms.TextInput(attrs={'class': 'form-control', 'placeholder':'Введите комментарий', 'autocomplete':'off'}),
        }


class CommentAddForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = ['rating', 'add_text']
        CHOICES = (('1', '1'), ('2', '2'), ('3', '3'), ('4', '4'), ('5', '5'))

        widgets = {
            'rating': forms.Select(choices=CHOICES, attrs={'class': 'd-none'}),
            'add_text': forms.TextInput(attrs={'class': 'form-control'}),
        }


class ReplyForm(forms.ModelForm):
    class Meta:
        model = Reply
        fields = ['text']

        widget = {
            'text': forms.TextInput(attrs={'class': 'form-control'})
        }


class ImageCommentForm(forms.ModelForm):
    class Meta:
        model = ImageComment
        fields = ['images_comment']

        widgets = {
            'images_comment': forms.FileInput(attrs={'class': 'form-control', 'multiple': 'multiple'}),
        }

    # def clean_text(self):
    #     new_comment = self.cleaned_data['text']
    #
    #     if new_comment == '':
    #         raise ValidationError('Пустой комментарий')
    #     return new_comment


    # def __init__(self, *args, **kwargs):
    #     super().__init__(*args, **kwargs)
    # #     for fields in self.fields:
    # #         self.fields[field].widget.attrs['class'] = 'form-control'
    #     self.fields['text'].widget = Textarea(attrs={'rows':5})
