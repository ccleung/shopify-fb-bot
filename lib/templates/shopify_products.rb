module Template
  # generic template
  class ShopifyProducts < Facebook::Messenger::Template::Generic
    def initialize(products)
      @products = products
    end

    def generic_items
      @products.map { |prod| ShopifyProduct.new(prod) }
    end
  end
end
