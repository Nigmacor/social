from django.shortcuts import render, get_object_or_404, redirect, reverse
from django.views.generic.base import TemplateResponseMixin, View
from django.http import Http404
from django.contrib.auth.decorators import login_required

from .forms import ProjectCreateForm, ProjectRespondForm
from .models import Module, Family, Project, ProjectRespond
from account.models import Profession, ProfileToProfession


from .work_list import work_dict

# Create your views here.
# r.set('projects:{}:{}'.format(obj.type.id, request.user.id)
@login_required
def index(request, profession_id):
    """
    Root page view. This is essentially a single-page app, if you ignore the
    login and admin parts.
    """
    # Получить список комнат, упорядоченных по алфавиту
    try:
        profession = Profession.objects.get(pk=profession_id,
                                rel_to_worker__worker=request.user.profile,
                                rel_to_worker__confirmed=True)
    except Profession.DoesNotExist:
        raise Http404
    profession = Profession.objects.get(pk=profession_id)
    job_queryset = profession.modules.order_by('-id')[:10]
    job_message_count = len(job_queryset)
    if job_message_count > 0:
        first_message_id = job_queryset[job_message_count - 1].id
    else:
        first_message_id = -1
        privious_id = -1
        job_messages = []
    if first_message_id != -1:
        try:
            privious_id = Module.objects.filter(pk__lt=first_message_id).order_by('-pk')[:1][0].id
        except IndexError:
            privious_id = -1
        job_messages = reversed(job_queryset)
    # Визуализируйте это в шаблоне индекса
    return render(request, "projects/project/index.html", {
        "profession": profession,
        "messages": job_messages,
        "privious_id": privious_id,
        "first_message_id": first_message_id,
        'user': request.user,
        'section': 'messages',
    })

@login_required
def module_detail(request, module_id):
    module = get_object_or_404(Module, id=module_id)
    professions = Profession.objects.filter(rel_to_worker__worker=request.user.profile,
                                           rel_to_worker__confirmed=True).order_by("title")
    if module.project.customer == request.user:
        responds_queryset = module.responds.order_by('-id')[:10]
        responds_message_count = len(responds_queryset)
        if responds_message_count > 0:
            first_message_id = responds_queryset[responds_message_count - 1].id
        else:
            first_message_id = -1
            privious_id = -1
            responds_messages = []
        if first_message_id != -1:
            try:
                privious_id = ProjectRespond.objects.filter(pk__lt=first_message_id).order_by('-pk')[:1][0].id
            except IndexError:
                privious_id = -1
            responds_messages = reversed(responds_queryset)
        return render(request, 'projects/project/module_owner.html', {'module': module,
                                                                      "responds": responds_messages,
                                                                      "privious_id": privious_id,
                                                                      "first_message_id": first_message_id,})
    elif module.profession in professions:
        return render(request, 'projects/project/module.html', {'module_id': module.id})
    else:
        raise Http404('Такой страницы нет')

@login_required
def respond_detail(request, respond_id):
    respond = ProjectRespond.objects.filter(id=respond_id,
                                            module__project__customer=request.user)
    return render(request, 'projects/project/respond_detail.html', {'respond': respond})


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
            # type = get_object_or_404(TypeOfWork, id=obj['type'])
            project = Project.objects.create(customer=request.user,
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

@login_required
def work_list(request):
    """
    Root page view. This is essentially a single-page app, if you ignore the
    login and admin parts.
    """
    professions = Profession.objects.filter(rel_to_worker__worker=request.user.profile,
                                           rel_to_worker__confirmed=True).order_by("title")

    # Визуализируйте это в шаблоне индекса
    return render(request, "projects/project/work_list.html", {
        "professions": professions,
    })


class RespondToProject(TemplateResponseMixin, View):
    template_name = 'projects/project/respond.html'
    def dispatch(self, request,  *args, **kwargs):
        try:
            self.module = Module.objects.get(pk=kwargs['module_id'])
        except:
            pass
        return super().dispatch(request, *args, **kwargs)

    def get(self, request, *args, **kwargs):
        form = ProjectRespondForm()
        try:
            prof_valid = ProfileToProfession.objects.filter(worker=request.user.profile,
                                                            profession=self.module.profession,
                                                            confirmed=True)
        except:
            return render(request, '404.html')
        if prof_valid:
            return self.render_to_response({'form': form})
        return render(request, '404.html')

    def post(self, request, *args, **kwargs):
        form = ProjectRespondForm(request.POST)
        if form.is_valid():
            cd = form.cleaned_data
            respond = form.save(commit=False)
            respond.module = self.module
            respond.responded = request.user
            respond.cost = cd['cost']
            respond.description = cd['description']
            respond.garanty = cd['garanty']
            respond.save()
        return redirect(reverse('work_list'))

@login_required
def projects_list(request):
    """
    Root page view. This is essentially a single-page app, if you ignore the
    login and admin parts.
    """
    projects = request.user.projects.all().order_by("id")

    # Визуализируйте это в шаблоне индекса
    return render(request, "projects/project/projects_list.html", {
        "projects": projects,
    })

class ProjectInspect(TemplateResponseMixin, View):
    template_name = 'projects/project/project_inspect.html'

    def get(self, request, *args, **kwargs):
        project = request.user.projects.get(pk=kwargs['project_id'])
        return self.render_to_response({'project': project})
