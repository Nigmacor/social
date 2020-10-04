from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.base import View
from django.core.paginator import Paginator
from django.core.files.images import ImageFile
from django.core.files.base import ContentFile

from .models import Comment, Reply, ImageComment
from .forms import CommentForm, CommentAddForm, ReplyForm, ImageCommentForm
from shops.models import ServiceType


# Create your views here.
class CommentCreate(View):
	def get_comment(self, request, product):
		comments_objects = Comment.objects.filter(product_or_service=product).order_by('-date')
		amount_of_comments = comments_objects.count()
		comment_form = CommentForm()
		images_form = ImageCommentForm()

		paginator = Paginator(comments_objects, 5)
		page_number = request.GET.get('page', 1)
		page = paginator.get_page(page_number)
		is_paginated = page.has_other_pages()
		if page.has_previous():
			prev_url = '?page={}'.format(page.previous_page_number())
		else:
			prev_url = ''
		if page.has_next():
			next_url = '?page={}'.format(page.next_page_number())
		else:
			next_url = ''

		summ_rating = 0
		for com in Comment.objects.filter(product_or_service=product):
			this_rating = com.rating
			summ_rating += this_rating

		if amount_of_comments != 0:
			overall_rating = summ_rating/amount_of_comments
			overall_rating = round(overall_rating, 2)

		else:
			overall_rating = 0

		context = {'page_object': page,
				   'is_paginated': is_paginated,
				   'next_url': next_url,
				   'prev_url': prev_url,
				   'comment_form': comment_form,
				   'amount_of_comments': amount_of_comments,
				   'rating': overall_rating,
				   'images_form': images_form}

		return context

	def post_comment(self, request, product):
		comment_bound_form = CommentForm(request.POST, request.FILES)
		images_bound_form = ImageCommentForm(request.POST, request.FILES)
		if comment_bound_form.is_valid() and images_bound_form.is_valid():
			cd = comment_bound_form.cleaned_data
			new_comment = Comment.objects.create(product_or_service=product, author=request.user, rating=cd['rating'], text=cd['text'])

			for image in request.FILES.getlist('images_comment'):
				new_image = ImageComment(comment=new_comment, images_comment=image)
				new_image.save()
			return


class CommentDelete(LoginRequiredMixin, View):
	def get(self, request, id, id_p):
		comment = Comment.objects.get(id=id)
		comment_bound_form = CommentForm(instance=comment)
		return render(request, 'comments/comment_delete_form.html',
					  context={'comment_form': comment_bound_form,
					  		   'comment': comment})

	def post(self, request, id, id_p):
		comment = Comment.objects.get(id=id)
		comment_bound_form = CommentForm(request.POST, instance=comment)
		comment.delete()
		return redirect('shop')


class CommentUpdate(LoginRequiredMixin, View):
	def get(self, request, id, id_p):
		comment = Comment.objects.get(id=id)
		comment_bound_form = CommentAddForm(instance=comment)
		return render(request, 'comments/comment_update_form.html',
					  context={'comment_form': comment_bound_form,
						  	   'comment': comment})

	def post(self, request, id, id_p):
		comment = Comment.objects.get(id=id)
		comment_bound_form = CommentAddForm(request.POST, instance=comment)

		if comment_bound_form.is_valid():
			add_to_comment = comment_bound_form.save()
			return redirect('shop')

		return render(request, 'comments/comment_update_form.html',
					  context={'comment_form': comment_bound_form,
					  		   'comment': comment})


class ReplyCreate(LoginRequiredMixin, View):
	def get(self, request, id, id_p):
		comment = Comment.objects.get(id=id)
		reply_objects = Reply.objects.filter(comment=comment).order_by('-date')
		reply_bound_form = ReplyForm()
		return render(request, 'comments/reply_form.html',
					  context={'comment': comment,
					  		   'reply': reply_objects,
					  		   'reply_form': reply_bound_form})

	def post(self, request, id, id_p):
		comment = Comment.objects.get(id=id)
		reply_bound_form = ReplyForm(request.POST)

		if reply_bound_form.is_valid():
			cd = reply_bound_form.cleaned_data
			new_reply = Reply.objects.create(comment=comment, author=request.user, text=cd['text'])
			return redirect('shop')

		return render(request, 'comments/reply_form.html',
					  context={'comment': comment,
					  		   'reply_form': reply_bound_form})


class ReplyDelete(LoginRequiredMixin, View):
	def get(self, request, id, id_c):
		reply = Reply.objects.get(id=id)
		reply_bound_form = ReplyForm(instance=reply)
		return render(request, 'comments/reply_delete_form.html',
					  context={'reply_form': reply_bound_form,
					  		   'reply': reply})

	def post(self, request, id, id_c):
		reply = Reply.objects.get(id=id)
		reply_bound_form = ReplyForm(request.POST, instance=reply)
		reply.delete()
		return redirect('shop')