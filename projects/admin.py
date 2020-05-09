from django.contrib import admin
from mptt.admin import DraggableMPTTAdmin

from .models import Project, Module, TypeOfWork

# Register your models here.

class ModuleInline(admin.StackedInline):
    model = Module

@admin.register(Project)
class AdminProject(admin.ModelAdmin):
    list_display = ['title', 'type', 'created']
    list_filter = ['type', 'created']
    search_fields = ['title', 'description']
    prepopulated_fields = {'slug': ('title',)}
    inlines = [ModuleInline]


class TypeOfWorkDraggableMPTTAdmin(DraggableMPTTAdmin):
    list_display = ['title', 'slug']
    prepopulated_fields = {'slug': ('title',)}
    mptt_level_indent = 20
    def something(self, instance):
        return format_html(
            '<div style="text-indent:{}px">{}</div>',
            instance._mpttfield('level') * self.mptt_level_indent,
            instance.title
        )
admin.site.register(TypeOfWork, TypeOfWorkDraggableMPTTAdmin,
    list_display=('tree_actions', 'indented_title'),
    list_display_links=('indented_title',)
    )
