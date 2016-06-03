module Facebook
  module Messenger
    module Subscriber
      # subscribers listen to events
      # and handle them in a call method
      class Base
        def call(event, shop_session)
        end

        def active_shopify_session(sender_id, shop_session)
          if shop_session
            begin
              ShopifyAPI::Base.activate_session(shop_session)
              yield
            ensure
              ShopifyAPI::Base.clear_session
            end
          else
            err_msg = 'Facebook Page not connected to Store!'
            Facebook::Messenger::Client.send_message_text(sender_id, err_msg)
          end
        end
      end
    end
  end
end
