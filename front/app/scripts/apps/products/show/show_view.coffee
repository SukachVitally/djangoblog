ShopManager.module "ProductsApp.Show", (Show, ShopManager, Backbone, Marionette, $, _)->

  class Show.MissingProduct extends Marionette.ItemView
    template: "productShowMissingItem"

  class Show.Product extends Marionette.ItemView
    template: "productShowItem"
