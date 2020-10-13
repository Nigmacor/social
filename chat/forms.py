from django import forms

class ChatInputForm(forms.Form):
    chat = forms.CharField(label='', widget=forms.widgets.Input(attrs={'type':'text', 'class':'form-control', 'id':'chat-input', 'placeholder':'Введите новое сообщение...'}))
    file = forms.FileField(required=False, label='ttt', widget=forms.widgets.FileInput(attrs={'id':'chat-file', 'multiple': 'multiple'}))
