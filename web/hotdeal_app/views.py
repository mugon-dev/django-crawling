from hotdeal_app.serializers import DealSerializers
from django.http import request
from hotdeal_app.models import Deal
from django.shortcuts import render
from rest_framework import viewsets
# Create your views here.
def index(requets):
    deals = Deal.objects.all().order_by("create_at")
    return render(requets, "index.html", {"deals": deals})

class DealViewSet(viewsets.ModelViewSet):
    queryset = Deal.objects.all()
    serializer_class = DealSerializers 