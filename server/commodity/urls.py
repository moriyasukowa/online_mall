from django.http import JsonResponse
from django.urls import path
from .views import *

urlpatterns = [
    path('list/', commodityView.as_view(), name='list'),
    path('detail/<int:id>/', detailView.as_view(), name='detail'),
    path('collect/', collectView.as_view(), name='collect'),
    path('search-suggestions/', CommoditySuggestionView.as_view(), name='commodity-search-suggestions'),
]