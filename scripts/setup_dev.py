import os
import django
import datetime
import json

os.environ["DJANGO_SETTINGS_MODULE"] = "myapp.settings"
django.setup()

from django.urls import reverse
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(email='admin@myapp.co').exists():
    User.objects.create_superuser(email='admin@myapp.co', password='picard data')
