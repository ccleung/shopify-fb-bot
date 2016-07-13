module Fb
  module Messenger
    module Event
      class Message < Base
        def text
          @event_data[:message][:text]
        end

        def mid
          @event_data[:message][:mid]
        end

        def seq
          @event_data[:message][:seq]
        end
      end
    end
  end
end
