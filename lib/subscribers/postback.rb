module Subscriber
  # subscribers listen to events
  # and handle them in a call method
  class Postback < Facebook::Messenger::Subscriber::Base
    def call(event, opts = {})
      shop_session = opts[:shop_session]
      payload = JSON.parse(event.payload)
      sender_id = event.sender_id
      case payload['type']
      when 'view_details'
        view_details(payload['id'], sender_id, shop_session)
      when 'order'
        # get user info from fb
        user_info = Facebook::Messenger::Client.user_info(sender_id)
        order(payload['id'], sender_id, user_info, shop_session)
      else
        Rails.logger.info ">>> unsupported postback: #{payload['type']}"
      end
    end

    private

    def order(id, sender_id, user_info, shop_session)
      Shopify::Request.execute(sender_id, shop_session) do
        product = ShopifyAPI::Product.find(id)
        order = create_order(product)
        if order
          template = ::Template::ShopifyOrder.new(order, product, user_info).template
          Facebook::Messenger::Client.send_message_template(sender_id, template)
        else
          Facebook::Messenger::Client.send_message(sender_id, 'Order cannot be fulfilled at this time')
        end
      end
    end

    def create_order(product)
      order = ShopifyAPI::Order.new
      order.attributes = {
        line_items: [
          {
            variant_id: product.id,
            quantity: 1,
            title: product.title,
            price: product.variants[0].price
          }
        ]
      }
      order if order.save
    end

    def view_details(id, sender_id, shop_session)
      Shopify::Request.execute(sender_id, shop_session) do
        product = ShopifyAPI::Product.find(id)
        Facebook::Messenger::Client.send_message_text(sender_id, product.body_html)
      end
    end
  end
end
