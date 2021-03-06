# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Article',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=50)),
                ('text', models.TextField()),
                ('created_date', models.DateField(auto_now=True)),
                ('author_id', models.IntegerField()),
                ('is_approved', models.BooleanField(default=False)),
                ('category_id', models.IntegerField(default=1, choices=[(1, b'News'), (2, b'Books'), (3, b'Documentation')])),
            ],
        ),
        migrations.CreateModel(
            name='ArticleTags',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('article', models.ForeignKey(to='djangoblog.Article')),
            ],
        ),
        migrations.CreateModel(
            name='Tag',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=50)),
            ],
        ),
        migrations.AddField(
            model_name='articletags',
            name='tag',
            field=models.ForeignKey(to='djangoblog.Tag'),
        ),
    ]
