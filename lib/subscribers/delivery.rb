module Subscriber
  # subscribers listen to events
  # and handle them in a call method
  class Delivery < Fb::Messenger::Subscriber::Base
    def call(event, opts = {})
      # Do nothing for now on delivery
    end
  end
end
