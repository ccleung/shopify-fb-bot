require 'facebook/messenger'

Facebook::Messenger.configure do |config|
  config.access_token = ENV['FB_MESSENGER_ACCESS_TOKEN']
  config.verify_token = ENV['FB_MESSENGER_VERIFY_TOKEN']
end
