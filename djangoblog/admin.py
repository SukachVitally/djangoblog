from django.contrib import admin
from djangoblog import models


admin.site.register(models.Article)
admin.site.register(models.Tag)
