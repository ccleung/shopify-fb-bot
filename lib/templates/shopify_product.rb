module Template
  # converts shopfiy product to template
  class ShopifyProduct < Fb::Messenger::Template::GenericItem
    def initialize(product)
      @product = product
    end

    def subtitle
      "price: #{price}"
    end

    def title
      @product.title
    end

    def buttons
      [
        Fb::Messenger::Template::Button.new(type: 'postback',
                                                  title: 'Order', payload: order_info_payload),
        Fb::Messenger::Template::Button.new(type: 'postback',
                                                  title: 'View Details', payload: view_details_payload)
      ]
    end

    def order_info_payload
      {
        type: 'order',
        id: @product.id
      }.to_json
    end

    def view_details_payload
      {
        type: 'view_details',
        id: @product.id
      }.to_json
    end

    def price
      @product.variants[0].price if @product.variants[0]
    end

    def image_url
      @product.image.src if @product.image
    end

    def description
      @product.body_html if @product.body_html
    end
  end
end
