define ["app"], (BlogManager)->
  BlogManager.module "BlogsApp.Registration", (Registration, BlogsApp, Backbone, Marionette, $, _)->
    Registration.Controller =
      showRegistration: ->
        require ["apps/blogs/registration/regisrtation_view"], ->
          registrationFormView = new Registration.Form()
          BlogsApp.mainRegion.show registrationFormView

  return BlogManager.BlogsApp.Registration.Controller