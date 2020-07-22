from django import forms

class ChatInputForm(forms.Form):
    chat = forms.CharField(label='', widget=forms.widgets.Input(attrs={'type':'text', 'class':'form-control', 'id':'chat-input', 'placeholder':'Введите новое сообщение...'}))
