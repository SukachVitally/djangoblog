define ["app", "apps/config/marionette/cors"], (BlogManager)->
  BlogManager.module "Entities", (Entities, BlogManager, Backbone, Marionette, $, _)->

    class Entities.Registration extends  Backbone.Model
      urlRoot: BlogManager.getUrl "registration"
