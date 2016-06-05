require 'facebook/messenger'
require 'shopify/request'

Facebook::Messenger.configure do |config|
  config.access_token = ENV['FB_MESSENGER_ACCESS_TOKEN']
  config.verify_token = ENV['FB_MESSENGER_VERIFY_TOKEN']
end

Facebook::Messenger::Receiver.configure do |receiver|
  receiver.subscribe 'message', Facebook::Messenger::Subscriber::Message.new
  receiver.subscribe 'postback', Facebook::Messenger::Subscriber::ViewDetails.new
  receiver.subscribe 'delivery', Facebook::Messenger::Subscriber::Delivery.new
end
