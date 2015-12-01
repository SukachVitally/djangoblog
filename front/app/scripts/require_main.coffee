requirejs.config
  baseUrl: "js",
  paths: {
    jquery: "../vendor/jquery/dist/jquery",
    backbone: "../vendor/backbone/backbone",
    underscore: "../vendor/underscore/underscore",
    marionette: "../vendor/backbone.marionette/lib/backbone.marionette",
    marionette: "../vendor/backbone.marionette/lib/backbone.marionette",
    jade: "../vendor/require-jade/jade",
    spin: "../vendor/spin.js/spin",
    "spin.jquery": "../vendor/spin.js/jquery.spin",
    "backbone.picky": "../vendor/backbone.picky/lib/backbone.picky",
    "backbone.syphon": "../vendor/backbone.syphon/lib/backbone.syphon",
  },
  shim: {
    underscore: {
      exports: "_"
    },
    backbone: {
      deps: ["jquery", "underscore", "jade", "spin.jquery"],
      exports: "Backbone"
    },
    marionette: {
      deps: ["backbone"],
      exports: "Marionette"
    },
    "spin.jquery": ["spin", "jquery"],
    "backbone.picky": ["backbone"],
    "backbone.syphon": ["backbone"]
  }

require ["app"], (BlogManager)->
  BlogManager.start()
