"""djangoblog URL Configuration"""
from django.conf.urls import include, url
from django.contrib import admin
from django.contrib.auth import views as auth_views
from . import views


urlpatterns = [
    url(r'^authenticate$', views.AuthView.as_view()),
    url(r'^registration$', views.RegisterView.as_view()),
    url(r'^articles$', views.ArticlesListView.as_view()),
    url(r'^articles/(?P<pk>[0-9]+)?$', views.ArticleView.as_view()),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^api/articles$', views.ArticlesApiView.as_view()),
    url(r'^api/articles/(?P<pk>[0-9]+)/$', views.ArticleApiView.as_view()),
    url(r'^api/similar_articles/(?P<pk>[0-9]+)$', views.SimilarArticlesApiView.as_view()),
]
