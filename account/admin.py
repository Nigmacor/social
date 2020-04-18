from django.contrib import admin
from .models import Profile, Profession

# Register your models here.
@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ['user', 'date_of_birth', 'photo']

@admin.register(Profession)
class ProfessionAdmin(admin.ModelAdmin):
    list_display = ['title', 'description']
