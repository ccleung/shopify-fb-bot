module Facebook
  module Messenger
    module Event
      # Delivery event
      class Delivery < Base
        def watermark
          @event_data[:delivery][:watermark]
        end

        def mids
          @event_data[:delivery][:mids]
        end

        def seq
          @event_data[:delivery][:seq]
        end
      end
    end
  end
end
