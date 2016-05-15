module Facebook
  module Messenger
    # EVENTS = {
    #   'message' => Facebook::Messenger::Event::Message
    # }.freeze
    # handles the incoming fb webhook data
    class Receiver
      class << self
        # expecting params[:entry]
        def receive(entries)
          entries.each do |entry|
            # TODO: save page id's
            puts "PAGE_ID: #{entry[:id]}"
            entry[:messaging].each do |msg_event|
              # TODO: default for unhandled event
              event_type = event_type(msg_event)
              event_class = event_type.classify
              event = "Facebook::Messenger::Event::#{event_class}".constantize.new(msg_event)
              SUBSCRIBERS[event_type].call(event)
            end
          end
        end

        def event_type(msg_event)
          return 'message' if msg_event[:message]
          return 'postback' if msg_event[:postback]
          handle_unsupported_event(msg_event)
        end

        def handle_unsupported_event(msg_event)
          binding.pry
          event = Facebook::Messenger::Event::Base.new(msg_event)
          Facebook::Messenger::Client.send_message_text(event.sender_id, "unsupported event: #{msg_event}")
        end
      end
    end
  end
end
