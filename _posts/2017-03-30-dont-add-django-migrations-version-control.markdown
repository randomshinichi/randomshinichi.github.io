---
author: admin
comments: true
date: 2017-03-30 14:11:58+00:00
layout: post
link: http://chiwbaka.com/dont-add-django-migrations-version-control/
slug: dont-add-django-migrations-version-control
title: Don't add Django migrations to version control
wordpress_id: 77
---

Django docs recommend a lot of things which don't really work out in reality.

For instance, having a single settings.py file. The only reason I can think of having it this way is so as not to overwhelm newcomers, because you need different settings for dev, production and staging.
A single tests.py for an app. Seriously, guys? You need test_views.py, test_models.py, test_manager.py, at least.

And here's the one thing that might be useful, might not: committing your migrations to version control.

Here's the situation: you're working on the models for a Django app.


    
    
    class Dog(models.Model):
        owner = models.ForeignKey(Person, on_delete=models.CASCADE)
        name = models.CharField(max_length=255)
        age = models.IntegerField()
    



Hmm, perhaps age should be date-of-birth. After all, you don't want to have to write some script to be updating the age value for every dog every year. No, perhaps it should be named dob after all.

So you make the change in models.py and add the migrations for the changes as well, they get saved as 0002_renamed_age_to_dob.py or something.

Problem is, your colleague has been working on the very same model, and he had added some other fields too:

    
    
    class Dog(models.Model):
        owner = models.ForeignKey(Person, on_delete=models.CASCADE)
        name = models.CharField(max_length=255)
        dob = models.DateField()
        fav_foods = models.CharField(max_length=255, blank=True)
        potty_trained = models.BooleanField(default=False)
    



The migration that changes the first code snippet to the second in PostgreSQL gets saved as 0002_added_fields.py, and now your django-migrate fails after a git pull. Because 0002_added_fields.py assumes that age is still there and it's a models.IntegerField, but the database on your machine looks different because you already renamed age to dob. Git can resolve conflicts between your models.py, but not between the Django migrations.

So it's best to just not add those migrations to the code repository unless you're really sure that only one guy is working on the models. Because if more than one guy is working on the models, then everybody's databases are different and the migrations can't resolve that. You might as well do django-manage makemigrations from scratch.

Unless, of course, you already have data in there.
