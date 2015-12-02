define ["app"], (BlogManager)->
  BlogManager.module "BlogsApp", (BlogsApp, BlogManager, Backbone, Marionette, $, _)->
    class BlogsApp.Router extends Marionette.AppRouter
      appRoutes:
        "registration": "blogRegistration"

    API =
      blogRegistration: ->
        require ["apps/blogs/registration/registration_controller"], (RegistrationController)->
          RegistrationController.showRegistration()

    BlogManager.on "blogs:registration", ->
      BlogManager.navigate "registration"
      API.blogRegistration()

    BlogManager.addInitializer ->
      new BlogsApp.Router
        controller: API
