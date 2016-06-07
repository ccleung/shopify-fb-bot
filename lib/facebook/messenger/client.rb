module Facebook
  module Messenger
    ENDPOINT = 'https://graph.facebook.com/v2.6/me/messages'.freeze
    # fb rest client
    class Client
      class << self
        def send(payload)
          RestClient.post("#{ENDPOINT}?access_token=#{Facebook::Messenger.config.access_token}",
                          payload.to_json, content_type: :json, accept: :json)
        rescue RestClient::ExceptionWithResponse => err
          Rails.logger.info ">>> #{err.response}"
          raise
        end

        def send_message_template(recipient, template)
          payload = {
            recipient: {
              id: recipient
            },
            message: template
          }
          send(payload)
        end

        def send_message_text(recipient, text)
          payload = {
            recipient: {
              id: recipient
            },
            message: {
              text: text
            }
          }
          send(payload)
        end
      end
    end
  end
end
