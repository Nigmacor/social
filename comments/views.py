from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.base import View
from django.core.paginator import Paginator
from django.core.files.images import ImageFile
from django.core.files.base import ContentFile

from .models import Comment, Reply, ImageComment, ComplaintComment, ComplaintReply
from .forms import CommentForm, CommentAddForm, ReplyForm, ImageCommentForm, ComplaintCommentForm, ComplaintReplyForm
from shops.models import ServiceType
from .utils import ObjectDeleteMixin
from orders.models import OrderItem


# Create your views here.
class CommentCreate(View):
	def get_comment(self, request, product):
		comments_objects = Comment.objects.filter(product_or_service=product).order_by('-date')
		amount_of_comments = comments_objects.count()
		context = {}

		if request.user.is_authenticated:
			order_objects = OrderItem.objects.filter(order__user=request.user)
			for order in order_objects:
				if order.product==product:
					comment_form = CommentForm()
					images_form = ImageCommentForm()
					context_forms = {'comment_form': comment_form,
						   	     	 'images_form': images_form}
					context.update(context_forms)

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

		context_all = {'page_object': page,
				   	   'is_paginated': is_paginated,
				       'next_url': next_url,
				       'prev_url': prev_url,
				       'amount_of_comments': amount_of_comments,
				       'rating': overall_rating}

		context.update(context_all)
		return context

	def post_comment(self, request, product):
		comment_bound_form = CommentForm(request.POST, request.FILES)
		images_bound_form = ImageCommentForm(request.POST, request.FILES)

		order_objects = OrderItem.objects.filter(order__user=request.user)
		for order in order_objects:
			if order.product==product and comment_bound_form.is_valid() and images_bound_form.is_valid():
				cd = comment_bound_form.cleaned_data
				new_comment = Comment.objects.create(product_or_service=product, author=request.user, rating=cd['rating'], text=cd['text'])

				for image in request.FILES.getlist('images_comment'):
					new_image = ImageComment(comment=new_comment, images_comment=image)
					new_image.save()
				return


class CommentDelete(LoginRequiredMixin, ObjectDeleteMixin, View):
    model = Comment
    bound_form = CommentForm
    template = 'comments/comment_delete_form.html'
    url = 'shop'


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


class ReplyDelete(LoginRequiredMixin, ObjectDeleteMixin, View):
    model = Reply
    bound_form = ReplyForm
    template = 'comments/reply_delete_form.html'
    url = 'shop'


class ComplaintCommentCreate(LoginRequiredMixin, View):
	def get(self, request, id, id_p):
		comment = Comment.objects.get(id=id)
		complaint_bound_form = ComplaintCommentForm()
		context_complaint = {'complaint_form': complaint_bound_form}
		return render(request, 'comments/complaint_comment_form.html',
					  context={'comment': comment,
					  		   'complaint_form': complaint_bound_form})

	def post(self, request, id, id_p):
		comment = Comment.objects.get(id=id)
		complaint_bound_form = ComplaintCommentForm(request.POST)

		if complaint_bound_form.is_valid():
			cd = complaint_bound_form.cleaned_data
			new_complaint = ComplaintComment.objects.create(comment=comment, author=request.user, complaint=cd['complaint'])
			return redirect('shop')

		# complaint = complaint_bound_form.save()
		return render(request, 'comments/complaint_comment_form.html',
					  context={'comment': comment,
					  		   'complaint_form': complaint_bound_form})


class ComplaintReplyCreate(LoginRequiredMixin, View):
	def get(self, request, id, id_c):
		reply = Reply.objects.get(id=id)
		complaint_bound_form = ComplaintReplyForm()
		context_complaint = {'complaint_form': complaint_bound_form}
		return render(request, 'comments/complaint_reply_form.html',
					  context={'reply': reply,
					  		   'complaint_form': complaint_bound_form})

	def post(self, request, id, id_c):
		reply = Reply.objects.get(id=id)
		complaint_bound_form = ComplaintReplyForm(request.POST)

		if complaint_bound_form.is_valid():
			cd = complaint_bound_form.cleaned_data
			new_complaint = ComplaintReply.objects.create(reply=reply, author=request.user, complaint=cd['complaint'])
			return redirect('shop')

		# complaint = complaint_bound_form.save()
		return render(request, 'comments/complaint_reply_form.html',
					  context={'reply': reply,
					  		   'complaint_form': complaint_bound_form})
