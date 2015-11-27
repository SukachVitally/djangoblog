ShopManager.module "SidebarApp.List", (List, ShopManager, Backbone, Marionette, $, _)->

  class List.Link extends Marionette.ItemView
    template: "sidebarLink"
    tagName: "li"
    triggers:
      "click a.js-show-group": "group:show"

    onRender: ->
      @$el.addClass "active" if @model.selected

  class List.Links extends Marionette.CompositeView
    className: "container-fluid"
    template: "sidebarLayout"
    childView: List.Link
    childViewContainer: "ul.js-group-list"
    triggers:
      "click a.js-show-all-groups": "products:list"

    activateMainLink: ->
      @$('ul.js-all-group li').addClass 'active'

    deactivateMainLink: ->
      @$('ul.js-all-group li').removeClass 'active'