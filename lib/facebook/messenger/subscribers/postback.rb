module Facebook
  module Messenger
    module Subscriber
      # subscribers listen to events
      # and handle them in a call method
      class Postback < Base
        def call(event, opts = {})
          shop_session = opts[:shop_session]
          payload = JSON.parse(event.payload)
          sender_id = event.sender_id
          case payload['type']
          when 'view_details'
            view_details(payload['id'], sender_id, shop_session)
          when 'order'
            order(payload['id'], sender_id, shop_session)
          else
            Rails.logger.info ">>> unsupported postback: #{payload['type']}"
          end
        end

        private

        def order(id, sender_id, shop_session)
          Shopify::Request.execute(sender_id, shop_session) do
            product = ShopifyAPI::Product.find(id)
            template = Facebook::Messenger::Template::ShopifyOrder.new(product).template
            Facebook::Messenger::Client.send_message_template(sender_id, template)
          end
        end

        def view_details(id, sender_id, shop_session)
          Shopify::Request.execute(sender_id, shop_session) do
            product = ShopifyAPI::Product.find(id)
            Facebook::Messenger::Client.send_message_text(sender_id, product.body_html)
          end
        end
      end
    end
  end
end
