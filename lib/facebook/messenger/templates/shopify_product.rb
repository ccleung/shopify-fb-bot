module Facebook
  module Messenger
    module Template
      # converts shopfiy product to template
      class ShopifyProduct
        def initialize(product)
          @product = product
        end

        def template
          {
            title: @product.title,
            subtitle: "price: #{price}",
            image_url: image_url,
            buttons: buttons
          }
        end

        def buttons
          [
            {
              type: 'web_url',
              url: 'https://www.messenger.com/',
              title: 'Web url'
            },
            {
              type: 'postback',
              title: 'Postback',
              payload: 'Payload for first element in a generic bubble'
            }
          ]
        end

        def price
          @product.variants[0].price if @product.variants[0]
        end

        def image_url
          @product.image.src if @product.image
        end

        def description
          @product.body_html if @product.body_html
        end
      end
    end
  end
end
