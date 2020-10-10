from django.shortcuts import render, redirect


class ObjectDeleteMixin:
    model = None
    bound_form = None
    template = None
    url = None
    def get(self, request, id, id_p):
        obj = self.model.objects.get(id=id)
        obj_bound_form = self.bound_form(instance=obj)
        return render(request, self.template,
					  context={'form': obj_bound_form,
					  		   self.model.__name__.lower(): obj})

    def post(self, request, id, id_p):
        obj = self.model.objects.get(id=id)
        obj_bound_form = self.bound_form(request.POST, instance=obj)
        obj.delete()
        return redirect(self.url)
