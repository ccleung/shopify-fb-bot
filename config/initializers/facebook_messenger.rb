require 'facebook/messenger'
require 'shopify/request'
require 'subscribers/message'
require 'subscribers/postback'
require 'subscribers/delivery'
require 'templates/shopify_product'
require 'templates/shopify_products'
require 'templates/shopify_order'

Fb::Messenger.configure do |config|
  config.access_token = ENV['FB_MESSENGER_ACCESS_TOKEN']
  config.verify_token = ENV['FB_MESSENGER_VERIFY_TOKEN']
end

Fb::Messenger::Receiver.configure do |receiver|
  receiver.subscribe 'message', ::Subscriber::Message.new
  receiver.subscribe 'postback', ::Subscriber::Postback.new
  receiver.subscribe 'delivery', ::Subscriber::Delivery.new
end
