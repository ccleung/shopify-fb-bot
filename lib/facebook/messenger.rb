# https://github.com/hyperoslo/facebook-messenger
require 'facebook/messenger/configuration'
require 'facebook/messenger/client'
require 'facebook/messenger/templates/shopify_product'
require 'facebook/messenger/templates/shopify_products'
require 'facebook/messenger/events/base'
require 'facebook/messenger/events/message'
require 'facebook/messenger/events/postback'
require 'facebook/messenger/events/delivery'
require 'facebook/messenger/subscribers/base'
require 'facebook/messenger/subscribers/message'
require 'facebook/messenger/subscribers/view_details'
require 'facebook/messenger/subscribers/delivery'
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
