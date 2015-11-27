ShopManager.module "ProductsApp.List", (List, ShopManager, Backbone, Marionette, $, _)->

  class List.Layout extends Marionette.LayoutView
    template: "productListLayout"
    regions:
      panelRegion: "#panel-region"
      productsRegion: "#products-region"


  class List.Product extends Marionette.ItemView
    tagName: "tr",
    template: "productListItem"
    triggers:
      "click td a.js-show": "product:show"


  class NoProductsView extends Marionette.ItemView
    template: "productListNone"
    tagName: "tr"
    className: "alert"

  class List.Products extends Marionette.CompositeView
    tagName: "table"
    className: "table table-hover"
    template: "productList"
    emptyView: NoProductsView
    childViewContainer: "tbody"
    childView: List.Product

    initialize: ->
      @listenTo @collection, "reset", ->
        @appendHtml = (collectionView, itemView, index)->
          collectionView.$el.append itemView.el

    onCompositeCollectionRendered: ->
      @appendHtml = (collectionView, itemView, index)->
        collectionView.$el.prepend itemView.el


