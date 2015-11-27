ShopManager.module "SidebarApp", (Sidebar, ShopManager, Backbone, Marionette, $, _)->
  API =
    listSidebar: ->
      Sidebar.List.Controller.listSidebar()

  Sidebar.on "start", ->
    API.listSidebar()
