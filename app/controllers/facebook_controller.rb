class FacebookController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_session_id, only: [:webhook]
  around_filter :shopify_session, only: [:webhook]

  def set_session_id
    # TODO: make this more flexible...
    session[:shopify] = 1
  end

  def verify
    verify_token = Facebook::Messenger.config.verify_token
    return render text: params['hub.challenge'] if params['hub.verify_token'] == verify_token
    head 200
  end

  def webhook
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
    messaging_events = params[:entry][0][:messaging]
    messaging_events.each do |msg_event|
      sender = msg_event[:sender][:id]
      if msg_event[:postback]
        msg_data = send_text_message_data("postback received: #{msg_event[:postback]}")
        send_message(sender, msg_data)
      elsif msg_event[:message] && msg_event[:message][:text]
        text = msg_event[:message][:text]
        msg_data = send_text_message_data(text)
        msg_data = generic_message_data if text.downcase == 'generic'
        send_message(sender, msg_data)
      end
    end
    head 200
  end

  def send_message(sender, message_data)
    payload = {
      recipient: {
        id: sender
      },
      message: message_data
    }
    RestClient.post("https://graph.facebook.com/v2.6/me/messages?access_token=#{Facebook::Messenger.config.access_token}",
                    payload.to_json, content_type: :json, accept: :json)
  end

  def send_text_message_data(text)
    {
      text: text
    }
  end

  def generic_message_data
    {
      attachment:
        {
          type: 'template',
          payload: {
            template_type: 'generic',
            elements:
              [
                {
                  title: 'First card',
                  subtitle: 'Element #1 of an hscroll',
                  image_url: 'http://messengerdemo.parseapp.com/img/rift.png',
                  buttons:
                    [
                      {
                        type: 'web_url',
                        url: 'https://www.messenger.com/',
                        title: 'Web url'
                      },
                      {
                        type: 'postback',
                        title: 'Postback',
                        payload: 'Payload for first element in a generic bubble'
                      }
                    ]
                },
                {
                  title: 'Second card',
                  subtitle: 'Element #2 of an hscroll',
                  image_url: 'http://messengerdemo.parseapp.com/img/gearvr.png',
                  buttons: [{
                    type: 'postback',
                    title: 'Postback',
                    payload: 'Payload for second element in a generic bubble'
                  }]
                }
              ]
            }
          }
      }
  end
end
