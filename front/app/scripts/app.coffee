root = exports ? this

root.ShopManager = new Marionette.Application()

root.ShopManager.addRegions
  mainRegion: "#main-region"
  sidebarRegion: "#sidebar-region"
#  dialogRegion: Dialog
  headerRegion: "#header-region"

root.ShopManager.navigate = (route, options)->
  options = options || {}
  Backbone.history.navigate route, options

root.ShopManager.getCurrentRoute = ->
  Backbone.history.fragment

root.ShopManager.on "start", ->
  if Backbone.history
    Backbone.history.start()
    if @getCurrentRoute() is ""
      root.ShopManager.trigger "products:list"
