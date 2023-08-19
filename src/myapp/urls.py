from django.conf import settings
from django.contrib import admin
from django.urls import include, path

from myapp import views

urlpatterns = [
    path("", views.index),
    path('admin/', admin.site.urls),
]

if settings.DEBUG:
    import debug_toolbar
    urlpatterns = [
        path('__debug__/', include(debug_toolbar.urls)),
    ] + urlpatterns
