from django.contrib import admin
from mptt.admin import DraggableMPTTAdmin

from .models import Project, Module, ProjectRespond

# Register your models here.
@admin.register(ProjectRespond)
class ProjectRespondAdmin(admin.ModelAdmin):
    list_display = ['id', 'module', 'responded', 'created']

class ModuleInline(admin.StackedInline):
    model = Module

@admin.register(Project)
class AdminProject(admin.ModelAdmin):
    list_display = ['title', 'created']
    list_filter = ['created']
    search_fields = ['title', 'description']
    prepopulated_fields = {'slug': ('title',)}
    inlines = [ModuleInline]


# class TypeOfWorkDraggableMPTTAdmin(DraggableMPTTAdmin):
#     list_display = ['title', 'slug', 'id']
#     prepopulated_fields = {'slug': ('title',)}
#     mptt_level_indent = 20
#     def something(self, instance):
#         return format_html(
#             '<div style="text-indent:{}px">{}</div>',
#             instance._mpttfield('level') * self.mptt_level_indent,
#             instance.title
#         )
# admin.site.register(TypeOfWork, TypeOfWorkDraggableMPTTAdmin,
#     list_display=('tree_actions', 'indented_title', 'id'),
#     list_display_links=('indented_title',)
#     )
