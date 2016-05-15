module Facebook
  module Messenger
    module Subscriber
      # subscribers listen to events
      # and handle them in a call method
      class Delivery < Base
        def call(event)
          # Do nothing for now on delivery
        end
      end
    end
  end
end
