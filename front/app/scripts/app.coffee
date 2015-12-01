define ["marionette"], (Marionette)->

  BlogManager = new Marionette.Application()

  BlogManager.addRegions
    mainRegion: "#main-region"
    dialogRegion: "#dialog-region"
    headerRegion: "#header-region"

  BlogManager.navigate = (route, options)->
    options = options || {}
    Backbone.history.navigate route, options

  BlogManager.getCurrentRoute = ->
    Backbone.history.fragment

  BlogManager.on "start", ->
    if Backbone.history
      require ['apps/header/header_app'], =>
        Backbone.history.start()

#      require ['apps/products/products_app'], =>
#        Backbone.history.start()
#        if @getCurrentRoute() is ""
#          ShopManager.trigger "products:list"

  BlogManager.getUrl = (url)->
    "#{location.protocol}//#{location.hostname}:8080/#{url}"

  return BlogManager
