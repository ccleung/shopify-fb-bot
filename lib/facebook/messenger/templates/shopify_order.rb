module Facebook
  module Messenger
    module Template
      class ShopifyOrder
        def initialize(product)
          @product = product
        end

        def template
          {
            attachment: {
              type: 'template',
              payload: {
                template_type: 'receipt',
                recipient_name: 'Clement Leung',
                order_number: '12345678902',
                currency: 'USD',
                payment_method: 'N/A', # required field
                order_url: 'http://petersapparel.parseapp.com/order?order_id=123456',
                timestamp: Time.now.to_i, # time zone?
                elements: [
                  {
                    title: @product.title,
                    subtitle: @product.body_html,
                    quantity: 1,
                    price: @product.variants[0].price,
                    currency: 'USD',
                    image_url: @product.image.src
                  }
                ],
                summary: {
                  total_cost: @product.variants[0].price
                }
              }
            }
          }
        end
      end
    end
  end
end
