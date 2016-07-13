module Fb
  module Messenger
    module Subscriber
      # subscribers listen to events
      # and handle them in a call method
      class Base
        def call(event, opts = {})
        end
      end
    end
  end
end
