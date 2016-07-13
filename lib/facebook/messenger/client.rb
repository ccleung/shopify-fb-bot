module Fb
  module Messenger
    BASE_URL = 'https://graph.facebook.com/v2.6'.freeze

    # fb rest client
    class Client
      class << self
        def send(payload)
          RestClient.post("#{BASE_URL}/me/messages?access_token=#{Fb::Messenger.config.access_token}",
                          payload.to_json, content_type: :json, accept: :json)
        rescue RestClient::ExceptionWithResponse => err
          Rails.logger.info ">>> #{err.response}"
          raise
        end

        def user_info(user_id)
          r = RestClient.get("#{BASE_URL}/#{user_id}",
                             params: { access_token: Fb::Messenger.config.access_token },
                             accept: :json)
          JSON.parse(r)
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
