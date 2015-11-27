ShopManager.module "HeaderApp.List", (List, ShopManager, Backbone, Marionette, $, _)->
  List.Controller =
    listHeader: ->
      links = ShopManager.request "header:entities"

      HeaderLinks = new List.Links collection: links

      HeaderLinks.on "products:filter", (filterCriterion)->
        ShopManager.trigger "products:filter", filterCriterion

      ShopManager.commands.setHandler "set:filter:criterion", (criterion)->
        HeaderLinks.triggerMethod "set:filter:criterion", criterion

      ShopManager.headerRegion.show HeaderLinks
