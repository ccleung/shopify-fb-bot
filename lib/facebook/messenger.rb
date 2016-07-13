# https://github.com/hyperoslo/facebook-messenger
require 'facebook/messenger/configuration'
require 'facebook/messenger/client'
require 'facebook/messenger/templates/button'
require 'facebook/messenger/templates/generic'
require 'facebook/messenger/templates/generic_item'
require 'facebook/messenger/templates/receipt'
require 'facebook/messenger/templates/receipt_item'
require 'facebook/messenger/events/base'
require 'facebook/messenger/events/message'
require 'facebook/messenger/events/postback'
require 'facebook/messenger/events/delivery'
require 'facebook/messenger/subscribers/base'
require 'facebook/messenger/receiver'

module Facebook
  # containers configuration
  module Messenger
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
