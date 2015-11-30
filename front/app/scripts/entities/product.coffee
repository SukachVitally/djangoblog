define ["app"], (ShopManager)->

  ShopManager.module "Entities", (Entities, ShopManager, Backbone, Marionette, $, _)->

    class Entities.Product extends  Backbone.Model
      urlRoot: "/shop/product/"
      full: false

      isFull: ->
        @full

      setFull: ->
        @full = true

      inGroup: (id)->
        id = parseInt(id, 10)
        groups = new Entities.ProductGroupCollection @get 'groups'
        groups.where(id: id).length isnt 0


    class Entities.ProductCollection extends Backbone.Collection
      url: "/shop/products/"
      model: Entities.Product

    products = null

    API =
      getProductEntities: ->
        defer = $.Deferred()
        if products
          defer.resolve products
        else
          products = new Entities.ProductCollection()
          products.fetch
            success: (data)->
              defer.resolve data

        defer.promise()

      getProductEntity: (productId)->
        defer = $.Deferred()

        $.when(@getProductEntities()).done (products)->
          product = products.get productId

          if product.isFull()
            defer.resolve product
          else
            product.fetch
              success: (data)->
                product.setFull()
                defer.resolve product
              error: (data)->
                defer.resolve null

        defer.promise()


    ShopManager.reqres.setHandler "product:entities", ->
      API.getProductEntities()

    ShopManager.reqres.setHandler "product:entity", (id)->
      API.getProductEntity(id)
