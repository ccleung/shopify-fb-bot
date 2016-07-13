module Template
  # generic template
  class ShopifyProducts < Fb::Messenger::Template::Generic
    def initialize(products)
      @products = products
    end

    def generic_items
      @products.map { |prod| ShopifyProduct.new(prod) }
    end
  end
end
