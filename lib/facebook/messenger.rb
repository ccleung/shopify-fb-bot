require 'facebook/messenger/configuration'

module Facebook
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
