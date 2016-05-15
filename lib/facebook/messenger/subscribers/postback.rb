module Facebook
  module Messenger
    module Subscriber
      # subscribers listen to events
      # and handle them in a call method
      class Postback < Base
        def call(event)
        end
      end
    end
  end
end
