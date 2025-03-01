
from django.shortcuts import render
from django.http import HttpResponse

def index(request):
    context = {
        "intro": "Hello world"
    }
    return render(request, "index.html", context)

def tmp_views(request): pass
