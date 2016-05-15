# https://github.com/hyperoslo/facebook-messenger
require 'facebook/messenger/configuration'
require 'facebook/messenger/client'
require 'facebook/messenger/events/base'
require 'facebook/messenger/events/message'
require 'facebook/messenger/events/postback'
require 'facebook/messenger/events/delivery'
require 'facebook/messenger/subscribers/base'
require 'facebook/messenger/subscribers/message'
require 'facebook/messenger/subscribers/postback'
require 'facebook/messenger/subscribers/delivery'
require 'facebook/messenger/receiver'

module Facebook
  # containers configuration
  module Messenger
    SUBSCRIBERS = {
      'message' => Facebook::Messenger::Subscriber::Message.new,
      'postback' => Facebook::Messenger::Subscriber::Postback.new,
      'delivery' => Facebook::Messenger::Subscriber::Postback.new
    }.freeze

    class << self
      def configure
        yield config
      end

      def config
        @config ||= Facebook::Messenger::Configuration.new
      end
    end
  end
end
