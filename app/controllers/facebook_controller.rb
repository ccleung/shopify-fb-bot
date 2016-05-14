class FacebookController < ActionController::Base
  def verify
    verify_token = Facebook::Messenger.config.verify_token
    return render text: params['hub.challenge'] if params['hub.verify_token'] == verify_token
    head 200
  end

  def webhook
    messaging_events = params[:entry][0][:messaging]
    messaging_events.each do |msg_event|
      sender = msg_event[:sender][:id]
      unless msg_event[:message].nil? || msg_event[:message][:text].nil?
        text = msg_event[:message][:text]
        send_message(sender, text)
      end
    end
    head 200
  end

  def send_message(sender, text)
    message_data = {
      text: text
    }
    payload = {
      recipient: {
        id: sender
      },
      message: message_data
    }
    RestClient.post("https://graph.facebook.com/v2.6/me/messages?access_token=#{Facebook::Messenger.config.access_token}",
                    payload.to_json, content_type: :json, accept: :json)
  end
end
