define ["app"], (BlogManager)->
  BlogManager.module "BlogsApp.Registration", (Registration, BlogManager, Backbone, Marionette, $, _)->
    Registration.Controller =
      showRegistration: ->
        require ["apps/blogs/registration/regisrtation_view", "entities/blog"], ->
          registrationFormView = new Registration.Form
          BlogManager.mainRegion.show registrationFormView

          registrationFormView.on 'form:submit', (data)->
            model = new BlogManager.Entities.Registration(data)
            model.save()

  return BlogManager.BlogsApp.Registration.Controller