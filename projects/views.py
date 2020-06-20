from django.shortcuts import render, get_object_or_404
from django.views.generic.base import TemplateResponseMixin, View


from .forms import ProjectCreateForm
from .models import Module, Family, Project, TypeOfWork
from account.models import Profession

from .work_list import work_dict

# Create your views here.
# r.set('projects:{}:{}'.format(obj.type.id, request.user.id)

class ProjectCreate(TemplateResponseMixin, View):
    template_name = 'projects/project/project.html'

    def get(self, request, *args, **kwargs):
        form = ProjectCreateForm()
        return self.render_to_response({'form': form})

    def post(self, request, *args, **kwargs):
        form = ProjectCreateForm(request.POST)
        if form.is_valid():
            module_list = []
            obj = form.cleaned_data
            type = get_object_or_404(TypeOfWork, id=obj['type'])
            project = Project.objects.create(customer=request.user,
                                             type=type,
                                             title=obj['title'],
                                             description=obj['description'])
            work_type = work_dict[str(obj['type'])]
            for module in range(int(work_type['modules_num'])):
                profession = get_object_or_404(Profession, id=work_type['to_professions'][str(module)])
                module_obj = Module.objects.create(title=work_type['modules_names'][str(module)],
                                                   project=project,
                                                   profession=profession)
                module_list.append(module_obj)

            for key, vals in work_type['hierarchy'].items():

                for val in vals:
                    Family.objects.create(parents=module_list[int(key)],
                                          childrens=module_list[int(val)])
    
        return self.render_to_response({'form': form})
