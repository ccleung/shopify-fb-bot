require 'rails_helper'

RSpec.describe Fb::Messenger::Event::Postback do
  let(:event_data) { build(:fb_msg_event, :postback) }
  subject { Fb::Messenger::Event::Postback.new(event_data) }

  context '#payload' do
    it 'returns payload' do
      expect(subject.payload).to eq('USER_DEFINIED_PAYLOAD')
    end
  end
end
