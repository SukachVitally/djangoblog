import bleach

from django.contrib.auth.models import User
from django.db.utils import IntegrityError
from djangoblog.exceptions import UserAlreadyExist
from rest_framework import serializers
from rest_framework.authtoken.models import Token

import models


class TagSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Tag
        fields = ('name',)


class ArticleSerializer(serializers.ModelSerializer):

    tags = TagSerializer(many=True, required=False)
    category = serializers.CharField(max_length=50)

    class Meta:
        model = models.Article
        fields = ('id', 'name', 'text', 'tags', 'category')

    def create(self, validated_data):
        tags = validated_data.pop('tags') if 'tags' in validated_data else []
        category = validated_data.pop('category')
        validated_data['text'] = bleach.clean(validated_data.get('text'))
        article = models.Article.objects.create(category_id=models.Article.get_category_id(category), **validated_data)
        article.save()
        for tag in tags:
            name = tag.get('name')
            try:
                tag = models.Tag.objects.get(name=name)
            except models.Tag.DoesNotExist:
                tag = models.Tag(name=name)
                tag.save()

            if not models.ArticleTags.objects.filter(article_id=article.id, tag_id=tag.id).count():
                    article_tag = models.ArticleTags(article_id=article.id, tag_id=tag.id)
                    article_tag.save()

        return article

    def update(self, instance, validated_data):
        tags = validated_data.pop('tags') if 'tags' in validated_data else []
        instance.name = validated_data.get('name', instance.name)
        instance.text = bleach.clean(validated_data.get('text', instance.text))
        instance.save()
        models.ArticleTags.objects.filter(article_id=instance.id).delete()

        for tag in tags:
            name = tag.get('name')
            try:
                tag = models.Tag.objects.get(name=name)
            except models.Tag.DoesNotExist:
                tag = models.Tag(name=name)
                tag.save()

            if not models.ArticleTags.objects.filter(article_id=instance.id, tag_id=tag.id).count():
                article_tag = models.ArticleTags(article_id=instance.id, tag_id=tag.id)
                article_tag.save()

        return instance


class AuthSerializer(serializers.Serializer):

    username = serializers.CharField(max_length=50)
    password = serializers.CharField(max_length=50)

    def create(self, validated_data):
        user = User.objects.get(username=validated_data.get('username'))
        if not user.check_password(validated_data.get('password')):
            raise User.DoesNotExist()

        try:
            token = Token.objects.get(user=user)
        except Token.DoesNotExist:
            token = Token.objects.create(user=user)
        return token.key


class RegisterSerializer(serializers.Serializer):

    username = serializers.CharField(max_length=50)
    first_name = serializers.CharField(max_length=50)
    last_name = serializers.CharField(max_length=50)
    email = serializers.EmailField(max_length=50)
    password = serializers.CharField(max_length=50)

    def create(self, validated_data):
        try:
            user = User.objects.create_user(**validated_data)
        except IntegrityError:
            raise UserAlreadyExist

        token = Token.objects.create(user=user)
        return token.key


