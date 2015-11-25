from django.contrib.auth.models import User
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import exceptions
from rest_framework import generics
from djangoblog import models
from djangoblog import serializers
from djangoblog.exceptions import UserAlreadyExist


class ArticlesApiView(generics.ListAPIView):
    queryset = models.Article.objects.all().filter(is_approved=True)
    serializer_class = serializers.ArticleSerializer


class ArticleApiView(generics.RetrieveAPIView):
    queryset = models.Article.objects.all()
    serializer_class = serializers.ArticleSerializer


class AuthView(APIView):

    permission_classes = ()

    def post(self, request):
        serializer = serializers.AuthSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        try:
            token = serializer.save()
        except User.DoesNotExist:
            raise exceptions.AuthenticationFailed('No such user')

        return Response({
            'token': token
        })


class RegisterView(APIView):

    permission_classes = ()

    def post(self, request):
        serializer = serializers.RegisterSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        try:
            token = serializer.save()
        except UserAlreadyExist:
            raise exceptions.PermissionDenied('User already exist')

        return Response({
            'token': token
        })


class ArticleView(APIView):

    permission_classes = (IsAuthenticated,)

    def get_object(self, pk):
        try:
            article = models.Article.objects.get(pk=pk)
        except models.Article.DoesNotExist:
            raise exceptions.NotFound

        return article

    def get(self, request, pk):
        snippet = self.get_object(pk)
        serializer = serializers.ArticleSerializer(snippet)
        return Response(serializer.data)

    def put(self, request, pk):
        snippet = self.get_object(pk)
        if snippet.author_id != request.user.id:
            raise exceptions.PermissionDenied

        serializer = serializers.ArticleSerializer(snippet, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)

    def delete(self, request, pk):
        snippet = self.get_object(pk)
        if snippet.author_id != request.user.id:
            raise exceptions.PermissionDenied

        models.ArticleTags.objects.filter(article_id=snippet.id).delete()
        snippet.delete()
        return Response({})

    def post(self, request, pk):
        serializer = serializers.ArticleSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save(author_id=request.user.id)
        return Response(serializer.data)


class ArticlesListView(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        articles = models.Article.objects.filter(author_id=request.user.id)
        serializer = serializers.ArticleSerializer(articles, many=True)
        return Response(serializer.data)


class SimilarArticlesApiView(APIView):
    permission_classes = ()

    def get_object(self, pk):
        try:
            article = models.Article.objects.get(pk=pk)
        except models.Article.DoesNotExist:
            raise exceptions.NotFound

        return article

    def get(self, request, pk):
        article = self.get_object(pk)
        article.similar_articles()
        serializer = serializers.ArticleSerializer(article.similar_articles(), many=True)
        return Response(serializer.data)
