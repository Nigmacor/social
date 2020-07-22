from django.urls import path
from .views import ProjectCreate, index, module_detail, work_list,\
RespondToProject, ProjectInspect, projects_list, respond_detail


urlpatterns = [
    path('create/', ProjectCreate.as_view(), name='project_create'),
    path('find/<int:profession_id>/', index, name='prochan'),
    path('module/<int:module_id>/', module_detail, name='module_detail'),
    path('work_list/', work_list, name='work_list'),
    path('projects_list/', projects_list, name='projects_list'),
    path('respond/<int:module_id>/', RespondToProject.as_view(), name='respond'),
    path('inspect/<int:project_id>/', ProjectInspect.as_view(), name='project_inspect'),
    path('respond_detail/<int:respond_id>/', respond_detail, name='respond_detail')


]
