module Facebook
  module Messenger
    # EVENTS = {
    #   'message' => Facebook::Messenger::Event::Message
    # }.freeze
    # handles the incoming fb webhook data
    class Receiver
      class << self
        # expecting params[:entry]
        def receive(entries, shop_session)
          entries.each do |entry|
            # TODO: save page id's
            puts "PAGE_ID: #{entry[:id]}"
            entry[:messaging].each do |msg_event|
              # TODO: default for unhandled event
              event_type = event_type(msg_event)
              unless event_type
                handle_unsupported_event(msg_event)
                next
              end
              event_class = event_type.classify
              event = "Facebook::Messenger::Event::#{event_class}".constantize.new(msg_event)
              SUBSCRIBERS[event_type].call(event, shop_session)
            end
          end
        end

        def event_type(msg_event)
          return 'message' if msg_event[:message]
          return 'postback' if msg_event[:postback]
          return 'delivery' if msg_event[:delivery]
        end

        def handle_unsupported_event(msg_event)
          Rails.logger.info "unsupported event: #{msg_event}"
        end
      end
    end
  end
end
