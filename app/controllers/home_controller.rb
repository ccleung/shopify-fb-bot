class HomeController < ShopifyApp::AuthenticatedController
  def index
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
    binding.pry
    @products
  end

  def login_again_if_different_shop
    binding.pry
    super
  end
end
