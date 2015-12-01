define ["app", "common/views"], (ShopManager)->
  ShopManager.module "ProductsApp.List", (List, ShopManager, Backbone, Marionette, $, _)->
    List.Controller =
      listProducts: (criterion)->

        loadingView = new ShopManager.Common.Views.Loading()
        ShopManager.mainRegion.show loadingView

        fetchingProducts = ShopManager.request "product:entities"

        $.when(fetchingProducts).done (products)->
          filteredProducts = ShopManager.Entities.FilteredCollection
            collection: products
            filterFunction: (filterCriterion)->
              criterion = filterCriterion.toLowerCase()
              (product)->
                if product.get('name').toLowerCase().indexOf(criterion) isnt -1
                  return product

          if criterion
            filteredProducts.filter criterion

          productsListView = new List.Products
            collection: filteredProducts

          productsListView.on "childview:product:show", (childView, args)->
            ShopManager.trigger "product:show", args.model.get("id")

          ShopManager.execute "clear:active:group"
          ShopManager.mainRegion.show productsListView

      listGroupProducts: (id)->
        loadingView = new ShopManager.Common.Views.Loading()
        ShopManager.mainRegion.show loadingView

        fetchingProducts = ShopManager.request "product:entities"
        $.when(fetchingProducts).done (products)->
          filteredProducts = ShopManager.Entities.FilteredCollection
            collection: products
            filterFunction: (id)->
              (product)->
                if product.inGroup(id)
                  return product

          filteredProducts.filter id.toString()

          productsListView = new List.Products
            collection: filteredProducts

          productsListView.on "childview:product:show", (childView, args)->
            ShopManager.trigger "product:show", args.model.get "id"

          ShopManager.execute "set:active:group", id
          ShopManager.mainRegion.show productsListView

  return ShopManager.ProductsApp.List.Controller