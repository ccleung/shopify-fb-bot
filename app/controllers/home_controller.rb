class HomeController < ShopifyApp::AuthenticatedController
  include Shoppable

  before_action :set_shop, only: [:index]

  def index
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
    @products
  end
end
