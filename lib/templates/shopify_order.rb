module Template
  class ShopifyOrder < Facebook::Messenger::Template::Receipt
    def initialize(order, product, user_info)
      @order = order
      # only support purchase of one product
      # at a time for now
      @product = product
      @user_info = user_info
    end

    # must default to non nil value
    def payment_method
      'N/A'
    end

    def recipient_name
      "#{@user_info['first_name']} #{@user_info['last_name']}"
    end

    def order_number
      @order.order_number.to_s
    end

    def currency
      @order.currency
    end

    # hardcode to dummy value for now as fb wants this
    def order_url
      'http://petersapparel.parseapp.com/order?order_id=123456'
    end

    def price
      @order.line_items[0].price
    end

    def quantity
      @order.line_items[0].quantity
    end

    def timestamp
      Time.parse(@order.created_at).to_i
    end

    def receipt_items
      opts = {
        title: @product.title,
        subtitle: @product.body_html,
        quantity: quantity,
        price: price,
        currency: @order.currency,
        image_url: @product.image.src
      }
      [Facebook::Messenger::Template::ReceiptItem.new(opts)]
    end

    def total_cost
      @order.total_line_items_price
    end
  end
end
