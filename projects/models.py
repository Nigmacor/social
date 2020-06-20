from django.db import models
from django.contrib.auth.models import User
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey
from mptt.models import MPTTModel, TreeManyToManyField, TreeForeignKey

from shops.models import Shop
from account.models import Profession


# Create your models here.

class TypeOfWork(MPTTModel):
    title = models.CharField(max_length=200)
    slug = models.SlugField(max_length=200, unique=True)
    parent = TreeForeignKey('self',
                            default=None,
                            null=True,
                            blank=True,
                            related_name='children',
                            on_delete=models.CASCADE)

    class Meta:
        ordering = ('title',)
        verbose_name = 'Вид работы'
        verbose_name_plural = 'Виды работ'

    def __str__(self):
        return self.title
    def get_ancestors(self):
        return super().get_ancestors(include_self=True)


class Project(models.Model):
    customer = models.ForeignKey(User, related_name='projects', on_delete=models.PROTECT)
    type = models.ForeignKey(TypeOfWork, related_name='projects', on_delete=models.PROTECT)
    title = models.CharField(max_length=200)
    slug = models.SlugField(max_length=200, unique=True)
    description = models.TextField()
    created = models.DateTimeField(auto_now_add=True)
    complited = models.BooleanField(default=False)

    class Meta:
        ordering = ['-created']
    def __str__(self):
        return self.title


class Producer(models.Model):
    producer = models.ForeignKey(Shop,
                                 related_name='projects',
                                 on_delete=models.PROTECT)
    take = models.DateTimeField(auto_now_add=True)
    def __str__(self):
        return self.producer.title

class Module(models.Model):
    producer = models.OneToOneField(Producer, blank=True, null=True, on_delete=models.PROTECT)
    project = models.ForeignKey(Project, related_name='modules', on_delete=models.CASCADE)
    title = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    complited = models.BooleanField(default=False)
    profession = models.ForeignKey(Profession,
                                   related_name='modules',
                                   blank=True, null=True,
                                   on_delete=models.PROTECT)
    

    def __str__(self):
        return self.title


class Family(models.Model):
    parents = models.ForeignKey(Module,
                                related_name='fam_parents',
                                on_delete=models.CASCADE)
    childrens = models.ForeignKey(Module,
                                  related_name='fam_childrens',
                                  on_delete=models.CASCADE)

# Динамическое добавление поля, избавиться при первой возможности
Module.add_to_class('parents', models.ManyToManyField('self',
                                                      through=Family,
                                                      related_name='childs',
                                                      symmetrical=False))

class Benchmark(models.Model):
    module = models.ForeignKey(Module, related_name='benchmarks', on_delete=models.CASCADE)
    title = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    status = models.BooleanField(verbose_name='статус', default=False)
    deadline = models.DateField(blank=True)

    def __str__(self):
        return self.title


class Content(models.Model):
    module = models.ForeignKey(Module,
                               related_name='contents',
                               on_delete=models.CASCADE)
    content_type = models.ForeignKey(ContentType,
                                     on_delete=models.CASCADE,
                                     limit_choices_to={'model__in':(
                                                                    'text',
                                                                    'video',
                                                                    'image',
                                                                    'file')})
    object_id = models.PositiveIntegerField()
    item = GenericForeignKey('content_type', 'object_id')


class AbstractItem(models.Model):
    producer = models.ForeignKey(Shop,
                                 related_name='%(class)s_for_project',
                                 on_delete=models.PROTECT)
    title = models.CharField(max_length=250)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True

    def __str__(self):
        return self.title

class Text(AbstractItem):
    content = models.TextField()
class File(AbstractItem):
    file = models.FileField(upload_to='projects/files/%Y/%m/%d/')
class Image(AbstractItem):
    image = models.ImageField(upload_to='projects/images/%Y/%m/%d/')
class Video(AbstractItem):
    url = models.URLField()
