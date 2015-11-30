requirejs.config
  baseUrl: "js",
  paths: {
    jquery: "../vendor/jquery/dist/jquery",
    backbone: "../vendor/backbone/backbone",
    underscore: "../vendor/underscore/underscore",
    marionette: "../vendor/backbone.marionette/lib/backbone.marionette",
    marionette: "../vendor/backbone.marionette/lib/backbone.marionette",
    app: "app"
  },
  shim: {
    underscore: {
      exports: "_"
    },
    backbone: {
      deps: ["jquery", "underscore"],
      exports: "Backbone"
    },
    marionette: {
      deps: ["backbone"],
      exports: "Marionette"
    }
  }

require ["app"], (ShopManager)->
  ShopManager.start()
