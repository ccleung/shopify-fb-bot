class FacebookController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_session, only: [:webhook]

  def verify
    verify_token = Facebook::Messenger.config.verify_token
    return render text: params['hub.challenge'] if params['hub.verify_token'] == verify_token
    head 200
  end

  def webhook
    Facebook::Messenger::Receiver.receive(params[:entry],
                                          shop_session: shop_session)
    head 200
  end

  private

  def set_session
    shop = Shop.find_by_facebook_id(page_id) if page_id
    session[:shopify] = shop.id if shop
  end

  def page_id
    params[:entry][0][:id].to_i
  end

  def sender_id
    params[:entry][0][:messaging][0][:sender][:id]
  end
end
