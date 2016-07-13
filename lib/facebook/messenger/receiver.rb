module Fb
  module Messenger
    # handles the incoming fb webhook data
    class Receiver
      class << self
        # expecting params[:entry]
        def receive(entries, opts = {})
          entries.each do |entry|
            entry[:messaging].each do |msg_event|
              # TODO: default for unhandled event
              event_type = event_type(msg_event)
              unless event_type
                handle_unsupported_event(msg_event)
                next
              end
              event_class = event_type.classify
              event = "Fb::Messenger::Event::#{event_class}".constantize.new(msg_event)
              config[event_type].call(event, opts)
            end
          end
        end

        def configure
          yield self
        end

        def subscribe(event, subscriber)
          config[event] = subscriber
        end

        def config
          @_config ||= {}
        end

        def event_type(msg_event)
          return 'message' if msg_event[:message]
          return 'postback' if msg_event[:postback]
          return 'delivery' if msg_event[:delivery]
        end

        def handle_unsupported_event(msg_event)
          Rails.logger.info ">>> unsupported event: #{msg_event}"
        end
      end
    end
  end
end
