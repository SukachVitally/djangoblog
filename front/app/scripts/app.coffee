define ["marionette"], (Marionette)->

  ShopManager = new Marionette.Application()

  ShopManager.addRegions
    mainRegion: "#main-region"
    sidebarRegion: "#sidebar-region"
    headerRegion: "#header-region"

  ShopManager.navigate = (route, options)->
    options = options || {}
    Backbone.history.navigate route, options

  ShopManager.getCurrentRoute = ->
    Backbone.history.fragment

  ShopManager.on "start", ->

    if Backbone.history
      Backbone.history.start()
      if @getCurrentRoute() is ""
        require ['apps/products/products_app'], ->
          ShopManager.trigger "products:list"
