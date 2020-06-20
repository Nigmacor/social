from django.contrib import admin
from .models import Profile, Profession, ProfileToProfession

# Register your models here.
@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ['user', 'date_of_birth', 'photo']

@admin.register(Profession)
class ProfessionAdmin(admin.ModelAdmin):
    list_display = ['title', 'id', 'description']

@admin.register(ProfileToProfession)
class ProfileToProfessionAdmin(admin.ModelAdmin):
    list_display = ['worker', 'profession', 'confirmed']
