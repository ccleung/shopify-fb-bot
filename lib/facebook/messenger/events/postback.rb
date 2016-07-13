module Fb
  module Messenger
    module Event
      # postback event
      class Postback < Base
        def payload
          @event_data[:postback][:payload]
        end
      end
    end
  end
end
