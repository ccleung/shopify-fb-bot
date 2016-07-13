module Fb
  module Messenger
    module Event
      # base event
      class Base
        def initialize(event_data)
          @event_data = event_data
        end

        def timestamp
          @event_data[:timestamp]
        end

        def sender_id
          @event_data[:sender][:id]
        end

        def recipient_id
          @event_data[:recipient][:id]
        end
      end
    end
  end
end
