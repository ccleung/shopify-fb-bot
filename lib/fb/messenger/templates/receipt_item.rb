module Fb
  module Messenger
    module Template
      class ReceiptItem
        attr_accessor :title, :subtitle, :quantity
        attr_accessor :price, :currency, :image_url

        def initialize(opts = {})
          @title = opts[:title]
          @subtitle = opts[:subtitle]
          @quantity = opts[:quantity]
          @price = opts[:price]
          @currency = opts[:currency]
          @image_url = opts[:image_url]
        end

        def template
          {
            title: title,
            subtitle: subtitle,
            quantity: quantity,
            price: price,
            currency: currency,
            image_url: image_url
          }
        end
      end
    end
  end
end
