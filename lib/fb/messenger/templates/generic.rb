module Fb
  module Messenger
    module Template
      # generic template
      class Generic
        attr_accessor :generic_items

        def initialize(opts = {})
          @generic_items = opts[:generic_items] || []
        end

        def template
          {
            attachment: {
              type: 'template',
              payload: {
                template_type: 'generic',
                elements: generic_items.map(&:template)
              }
            }
          }
        end
      end
    end
  end
end
