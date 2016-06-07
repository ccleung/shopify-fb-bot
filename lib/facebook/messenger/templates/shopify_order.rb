module Facebook
  module Messenger
    module Template
      class ShopifyOrder
        def initialize(order, product, user_info)
          @order = order
          # only support purchase of one product
          # at a time for now
          @product = product
          @user_info = user_info
        end

        def name
          "#{@user_info['first_name']} #{@user_info['last_name']}"
        end

        def price
          @order.line_items[0].price
        end

        def quantity
          @order.line_items[0].quantity
        end

        def timestamp
          Time.parse(@order.created_at).to_i
        end

        def template
          {
            attachment: {
              type: 'template',
              payload: {
                template_type: 'receipt',
                recipient_name: name,
                order_number: @order.order_number.to_s,
                currency: @order.currency,
                payment_method: 'N/A', # required field
                order_url: 'http://petersapparel.parseapp.com/order?order_id=123456',
                timestamp: timestamp,
                elements: [
                  {
                    title: @product.title,
                    subtitle: @product.body_html,
                    quantity: quantity,
                    price: price,
                    currency: @order.currency,
                    image_url: @product.image.src
                  }
                ],
                summary: {
                  total_cost: @order.total_line_items_price
                }
              }
            }
          }
        end
      end
    end
  end
end
