ShopManager.module "Entities", (Entities, ShopManager, Backbone, Marionette, $, _)->

  class Entities.ProductGroup extends  Backbone.Model
    initialize: ->
      _.extend @, Backbone.Picky.Selectable.prototype


  class Entities.ProductGroupCollection extends Backbone.Collection
    initialize: ->
      _.extend @, Backbone.Picky.SingleSelect.prototype

    url: "/shop/groups/"
    model: Entities.ProductGroup

  API =
    getGroupList: ->
      defer = $.Deferred()
      links = new Entities.ProductGroupCollection()
      links.fetch
        success: (data)->
          defer.resolve data
      defer.promise()

  ShopManager.reqres.setHandler "group:entities", ->
    API.getGroupList()
