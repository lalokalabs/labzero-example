
from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required

def index(request):
    context = {
        "intro": "Hello world"
    }
    return render(request, "index.html", context)

@login_required
def dashboard(request):
    return render(request, "dashboard.html")
