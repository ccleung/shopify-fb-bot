class Shop < ActiveRecord::Base
  include ShopifyApp::Shop
  include ShopifyApp::SessionStorage

  validates :facebook_id, uniqueness: true, allow_nil: true
end
