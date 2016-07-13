require 'fb/messenger/configuration'
require 'fb/messenger/client'
require 'fb/messenger/templates/button'
require 'fb/messenger/templates/generic'
require 'fb/messenger/templates/generic_item'
require 'fb/messenger/templates/receipt'
require 'fb/messenger/templates/receipt_item'
require 'fb/messenger/events/base'
require 'fb/messenger/events/message'
require 'fb/messenger/events/postback'
require 'fb/messenger/events/delivery'
require 'fb/messenger/subscribers/base'
require 'fb/messenger/receiver'

module Fb
  module Messenger
    class << self
      def configure
        yield config
      end

      def config
        @config ||= Fb::Messenger::Configuration.new
      end
    end
  end
end
