define ["app"], (BlogManager)->
  BlogManager.module "HeaderApp.List", (List, BlogManager, Backbone, Marionette, $, _)->
    List.Controller =
      listHeader: ->
        require ['apps/header/list/list_view', "entities/header"], (ListLinks) ->
          links = BlogManager.request "header:entities"
          HeaderLinks = new ListLinks collection: links
          BlogManager.headerRegion.show HeaderLinks

  return BlogManager.HeaderApp.List.Controller
