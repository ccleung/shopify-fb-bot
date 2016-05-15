module Facebook
  module Messenger
    module Subscriber
      # subscribers listen to events
      # and handle them in a call method
      class Message < Base
        def call(event)
          Facebook::Messenger::Client.send_message_text(event.sender_id, event.text)
        end
      end
    end
  end
end
