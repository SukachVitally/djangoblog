define [
  "app",
  "jade!apps/header/list/templates/headerLayout",
  "jade!apps/header/list/templates/headerLink"
], (BlogManager, headerLayoutTpl, headerLinkTpl)->
  BlogManager.module "HeaderApp.List", (List, ShopManager, Backbone, Marionette, $, _)->

    class List.Link extends Marionette.ItemView
      template: headerLinkTpl
      tagName: "li"

    class List.Links extends Marionette.CompositeView
      className: "container-fluid"
      template: headerLayoutTpl
      childView: List.Link
      childViewContainer: "ul"

  return BlogManager.HeaderApp.List.Links
