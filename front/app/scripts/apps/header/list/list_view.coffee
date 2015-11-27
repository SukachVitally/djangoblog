ShopManager.module "HeaderApp.List", (List, ShopManager, Backbone, Marionette, $, _)->

  class List.Link extends Marionette.ItemView
    template: "headerLink"
    tagName: "li"

  class List.Links extends Marionette.CompositeView
    className: "container-fluid"
    template: "headerLayout"
    childView: List.Link
    childViewContainer: "ul"
    events:
      "submit #header-filter-form": "filterProducts"
    ui:
      criterion: "input.js-filter-criterion"

    filterProducts: (e)->
      e.preventDefault()
      @trigger 'products:filter', @$('.js-filter-criterion').val()

    onSetFilterCriterion: (criterion)->
      @ui.criterion.val criterion
