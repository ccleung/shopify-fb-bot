module Facebook
  module Messenger
    module Subscriber
      # subscribers listen to events
      # and handle them in a call method
      class ViewDetails < Base
        def call(event)
          payload = JSON.parse(event.payload)
          return if payload['type'] != 'view_details'
          product_id = payload['id']
          product = ShopifyAPI::Product.find(product_id)
          Facebook::Messenger::Client.send_message_text(event.sender_id, product.body_html)
        end
      end
    end
  end
end
