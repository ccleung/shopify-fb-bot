module Facebook
  module Messenger
    module Template
      class Receipt
        attr_accessor :recipient_name, :order_number, :currency
        attr_accessor :payment_method, :order_url, :timestamp
        attr_accessor :total_cost, :receipt_items

        def initialize(opts = {})
          @recipient_name = opts[:recipient_name]
          @order_number = opts[:order_number]
          @currency = opts[:currency]
          # payment_method field cannot be nil
          @payment_method = opts[:payment_method] || 'N/A'
          @order_url = opts[:order_url]
          @timestamp = opts[:timestamp]
          @total_cost = opts[:total_cost]
          @receipt_items = opts[:receipt_items] || []
        end

        def template
          {
            attachment: {
              type: 'template',
              payload: {
                template_type: 'receipt',
                recipient_name: recipient_name,
                order_number: order_number,
                currency: currency,
                payment_method: payment_method, # required field
                order_url: order_url,
                timestamp: timestamp,
                elements: receipt_items.map(&:template),
                summary: {
                  total_cost: total_cost
                }
              }
            }
          }
        end
      end
    end
  end
end
