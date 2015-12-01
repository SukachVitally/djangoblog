define ["app"], (BlogManager)->
  BlogManager.module "HeaderApp.List", (List, BlogManager, Backbone, Marionette, $, _)->
    List.Controller =
      listHeader: ->
        require ['apps/header/list/list_view', "entities/header"], (ListLinks) ->
          links = BlogManager.request "header:entities"

          HeaderLinks = new ListLinks collection: links

          HeaderLinks.on "products:filter", (filterCriterion)->
            BlogManager.trigger "products:filter", filterCriterion

          BlogManager.commands.setHandler "set:filter:criterion", (criterion)->
            HeaderLinks.triggerMethod "set:filter:criterion", criterion

          BlogManager.headerRegion.show HeaderLinks

  return BlogManager.HeaderApp.List.Controller
