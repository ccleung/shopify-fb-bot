module Shopify
  class Request
    def self.execute(sender_id, shop_session)
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
