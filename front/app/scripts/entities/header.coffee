ShopManager.module "Entities", (Entities, ShopManager, Backbone, Marionette, $, _)->
  class Entities.Header extends Backbone.Model
      initialize: ->
        _.extend @, Backbone.Picky.Selectable.prototype

  class Entities.HeaderCollection extends Backbone.Collection
      model: Entities.Header
      initialize: ->
        _.extend @, Backbone.Picky.SingleSelect.prototype

  initializeHeaders = ->
    Entities.headers = new Entities.HeaderCollection [
      {name: "Contacts", url: "contacts",  navigationTrigger: "contacts:list"}
      {name: "About", url: "about",  navigationTrigger: "about:show"}
    ]

  API =
    getHeaders: ->
      if Entities.headers is undefined
        initializeHeaders()
      Entities.headers

  ShopManager.reqres.setHandler "header:entities", ->
    API.getHeaders()
