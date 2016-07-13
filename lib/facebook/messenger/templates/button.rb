module Facebook
  module Messenger
    module Template
      class Button
        attr_accessor :type, :title, :payload

        def initialize(opts = {})
          @type = opts[:type]
          @title = opts[:title]
          @payload = opts[:payload]
        end

        def template
          {
            type: type,
            title: title,
            payload: payload
          }
        end
      end
    end
  end
end
