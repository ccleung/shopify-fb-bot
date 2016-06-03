module Shoppable
  extend ActiveSupport::Concern

  private

  def set_shop
    @shop = Shop.find(session[:shopify])
  end
end
