define ["app", "backbone.picky"], (BlogManager)->
  BlogManager.module "Entities", (Entities, BlogManager, Backbone, Marionette, $, _)->
    class Entities.Header extends Backbone.Model
        initialize: ->
          _.extend @, Backbone.Picky.Selectable.prototype

    class Entities.HeaderCollection extends Backbone.Collection
        model: Entities.Header
        initialize: ->
          _.extend @, Backbone.Picky.SingleSelect.prototype

    initializeHeaders = ->
      Entities.headers = new Entities.HeaderCollection [
        {name: "Registration", url: "registration",  navigationTrigger: "blogs:registration"}
        {name: "Login", url: "authenticate",  navigationTrigger: "blogs:login"}
      ]

    API =
      getHeaders: ->
        if Entities.headers is undefined
          initializeHeaders()
        Entities.headers

    BlogManager.reqres.setHandler "header:entities", ->
      API.getHeaders()
