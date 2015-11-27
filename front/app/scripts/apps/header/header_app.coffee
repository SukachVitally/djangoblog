ShopManager.module "HeaderApp", (Header, ShopManager, Backbone, Marionette, $, _)->
  API =
    listHeader: ->
      Header.List.Controller.listHeader()

  Header.on "start", ->
    API.listHeader()

