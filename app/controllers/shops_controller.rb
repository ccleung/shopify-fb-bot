class ShopsController < ShopifyApp::AuthenticatedController
  include Shoppable

  before_action :set_shop, only: [:edit, :update]

  def edit
  end

  def update
    if @shop.update(shop_params)
      redirect_to :root
    else
      render :edit
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:facebook_id)
  end
end
