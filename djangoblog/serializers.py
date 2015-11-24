from django.contrib.auth.models import User
from django.db.utils import IntegrityError
from djangoblog.exceptions import UserAlreadyExist
from rest_framework import serializers
from rest_framework.authtoken.models import Token

import models


class TagSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Tag
        fields = ('id', 'name')


class ArticleSerializer(serializers.ModelSerializer):

    tags = TagSerializer(many=True)

    class Meta:
        model = models.Article
        fields = ('id', 'name', 'text', 'tags')


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


