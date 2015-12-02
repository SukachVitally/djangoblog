define ["app", "jade!apps/blogs/registration/templates/registrationForm", "backbone.syphon"], (BlogManager, registrationFromTpl)->
  BlogManager.module "BlogsApp.Registration", (Registration, BlogManager, Backbone, Marionette, $, _)->

    class Registration.Form extends Marionette.ItemView
      template: registrationFromTpl
      events:
          "click button.js-submit": "submitClicked"

      submitClicked: (e)->
        e.preventDefault()
        data = Backbone.Syphon.serialize(@)
        @trigger "form:submit", data
