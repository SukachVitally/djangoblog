ShopManager.module "Common.Views", (Views, ShopManager, Backbone, Marionette, $, _)->
  class Views.Loading extends Marionette.ItemView
    template: "loading"
    initialize: (options)->
      options = options || {}
      @title = options.titile || "Loading Data"
      @message = options.message || "Please weight, data is loading"

    serializeData: ->
      {
        title: @titile
        message: @message
      }

    onShow: ->
      opts =
        lines: 13
        length: 20
        width: 10
        radius: 30
        corners: 1
        rotate: 0
        direction: 1
        color: "#000"
        speed: 1
        trail: 60
        shadow: false
        hwaccel: false
        className: "spinner"
        zIndex: 2e9
        top: "30px"
        left: "auto"
      $("#spinner").spin opts
