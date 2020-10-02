"""
Django settings for social project.

Generated by 'django-admin startproject' using Django 2.2.6.

For more information on this file, see
https://docs.djangoproject.com/en/2.2/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/2.2/ref/settings/
"""

import os
from django.urls import reverse_lazy

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/2.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'evcl6xemvm2o!v#($e*qzi8+iv=y&2yx430f-$7+v%1mnskg^0'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = [
    'localhost',
    '127.0.0.1',
    '18.130.173.6'
]


# Application definition

INSTALLED_APPS = [
    'django_gulp',
    'django_sass',
    'account.apps.AccountConfig',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'images.apps.ImagesConfig',
    'sorl.thumbnail',
    'actions.apps.ActionsConfig',
    'mptt',
    'shops.apps.ShopsConfig',
    'cart.apps.CartConfig',
    'orders.apps.OrdersConfig',
    'payment.apps.PaymentConfig',
    'coupons.apps.CouponsConfig',
    'projects.apps.ProjectsConfig',
    'channels',
    'chat',
    'psycopg2',
    'comments.apps.CommentsConfig',

]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'social.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'cart.context_processor.cart',
            ],
        },
    },
]

WSGI_APPLICATION = 'social.wsgi.application'


# Database
# https://docs.djangoproject.com/en/2.2/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'soci',
        'USER': 'mplace_db',
        'PASSWORD': 'p123456789',
        'HOST': '127.0.0.1',
        'PORT': '5432'
    }
}


# Password validation
# https://docs.djangoproject.com/en/2.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/2.2/topics/i18n/

LANGUAGE_CODE = 'ru-ru'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/2.2/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'static/')


LOGIN_REDIRECT_URL = 'dashboard'
LOGIN_URL = 'login'
LOGOUT_URL = 'logout'

EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media/')

AUTHENTICATION_BACKENDS = [
    'django.contrib.auth.backends.ModelBackend',
    'account.authentication.EmailAuthBackend',
]

ABSOLUTE_URL_OVERRIDES = {
'auth.user': lambda u: reverse_lazy('user_detail', args=[u.username])
}

CART_SESSION_ID = 'cart'

REDIS_HOST = 'localhost'
REDIS_PORT = 6379
REDIS_DB = 0

# Настройки Braintree.
BRAINTREE_MERCHANT_ID = 'ffxw2bbwttvc6mcw' # ID продавца.
BRAINTREE_PUBLIC_KEY = '7yptkhk485xcd6xj' # Публичный ключ.
BRAINTREE_PRIVATE_KEY = 'bfcf1c21ccf48bfdf91a0421e2152aab' # Секретный ключ.
from braintree import Configuration, Environment
Configuration.configure(
    Environment.Sandbox,
    BRAINTREE_MERCHANT_ID,
    BRAINTREE_PUBLIC_KEY,
    BRAINTREE_PRIVATE_KEY
)

# chat
redis_host = os.environ.get('REDIS_HOST', 'localhost')


CHANNEL_LAYERS = {
    "default": {
        "BACKEND": "channels_redis.core.RedisChannelLayer",
        "CONFIG": {
            "hosts": [(redis_host, 6379)],
        },
    },
}

ASGI_APPLICATION = 'social.routing.application'


NOTIFY_USERS_ON_ENTER_OR_LEAVE_ROOMS = True

MSG_TYPE_MESSAGE = 0  # Для стандартных сообщений
MSG_TYPE_WARNING = 1  # Для желтых сообщений
MSG_TYPE_ALERT = 2  # Для красных и опасных оповещений
MSG_TYPE_MUTED = 3  # Для просто ОК информации, которая не беспокоит пользователей
MSG_TYPE_ENTER = 4  # Для просто ОК информации, которая не беспокоит пользователей
MSG_TYPE_LEAVE = 5  # Для просто ОК информации, которая не беспокоит пользователей

MESSAGE_TYPES_CHOICES = (
    (MSG_TYPE_MESSAGE, 'MESSAGE'),
    (MSG_TYPE_WARNING, 'WARNING'),
    (MSG_TYPE_ALERT, 'ALERT'),
    (MSG_TYPE_MUTED, 'MUTED'),
    (MSG_TYPE_ENTER, 'ENTER'),
    (MSG_TYPE_LEAVE, 'LEAVE'),
)

MESSAGE_TYPES_LIST = [
    MSG_TYPE_MESSAGE,
    MSG_TYPE_WARNING,
    MSG_TYPE_ALERT,
    MSG_TYPE_MUTED,
    MSG_TYPE_ENTER,
    MSG_TYPE_LEAVE,
]
