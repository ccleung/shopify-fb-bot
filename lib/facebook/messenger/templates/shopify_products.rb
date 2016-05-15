module Facebook
  module Messenger
    module Template
      # generic template
      class ShopifyProducts
        def initialize(products)
          @products = products
        end

        def elements
          @products.map { |prod| ShopifyProduct.new(prod).template }
        end

        def template
          {
            attachment: {
              type: 'template',
              payload: {
                template_type: 'generic',
                elements: elements
              }
            }
          }
        end
      end
    end
  end
end
