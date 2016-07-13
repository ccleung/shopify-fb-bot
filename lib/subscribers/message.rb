module Subscriber
  # subscribers listen to events
  # and handle them in a call method
  class Message < Facebook::Messenger::Subscriber::Base
    NOT_FOUND = "Sorry, we could not find the product your were looking for. Please type in a video game e.g., 'minecraft'".freeze
    def call(event, opts = {})
      Shopify::Request.execute(event.sender_id, opts[:shop_session]) do
        products = shopify_products(event.text)
        if products && products.length > 0
          template = ::Template::ShopifyProducts.new(products).template
          Facebook::Messenger::Client.send_message_template(event.sender_id, template)
        else
          Facebook::Messenger::Client.send_message_text(event.sender_id, NOT_FOUND)
        end
      end
    end

    def shopify_products(title)
      ShopifyAPI::Product.find(:all, params: { title: title })
    end
  end
end
