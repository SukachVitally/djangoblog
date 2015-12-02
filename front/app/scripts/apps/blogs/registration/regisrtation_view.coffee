define ["app", "jade!apps/blogs/registration/templates/registrationForm",], (BlogManager, registrationFromTpl)->
  BlogManager.module "BlogsApp.Registration", (Registration, BlogManager, Backbone, Marionette, $, _)->

    class Registration.Form extends Marionette.ItemView
      template: registrationFromTpl
