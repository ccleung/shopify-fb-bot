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
              type: 'postback',
              title: 'Order',
              payload: order_info_payload
            },
            {
              type: 'postback',
              title: 'View Details',
              payload: view_details_payload
            }
          ]
        end

        def order_info_payload
          {
            type: 'order',
            id: @product.id
          }.to_json
        end

        def view_details_payload
          {
            type: 'view_details',
            id: @product.id
          }.to_json
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
