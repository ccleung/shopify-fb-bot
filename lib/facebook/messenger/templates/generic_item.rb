module Fb
  module Messenger
    module Template
      class GenericItem
        attr_accessor :title, :subtitle, :image_url, :buttons

        def initialize(opts = {})
          @title = opts[:title]
          @subtitle = opts[:subtitle]
          @image_url = opts[:image_url]
          @buttons = opts[:buttons] || []
        end

        def template
          {
            title: title,
            subtitle: subtitle,
            image_url: image_url,
            buttons: buttons.map(&:template)
          }
        end
      end
    end
  end
end
