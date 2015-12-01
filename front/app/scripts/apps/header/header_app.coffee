define ["app"], (BlogManager)->
  BlogManager.module "HeaderApp", (Header, BlogManager, Backbone, Marionette, $, _)->
    API =
      listHeader: ->
        require ["apps/header/list/list_controller"], (ListController)->
          ListController.listHeader()

    Header.on "start", ->
      API.listHeader()

