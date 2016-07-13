require 'rails_helper'

RSpec.describe Fb::Messenger::Event::Base do
  let(:event_data) { build(:fb_msg_event) }
  subject { Fb::Messenger::Event::Base.new(event_data) }

  context '#timestamp' do
    it 'returns timestamp' do
      expect(subject.timestamp).to eq(1_463_254_696_945)
    end
  end

  context '#sender_id' do
    it 'returns sender_id' do
      expect(subject.sender_id).to eq(11_111_111_111_111_111)
    end
  end

  context '#recipient_id' do
    it 'returns recipient_id' do
      expect(subject.recipient_id).to eq(22_222_222_222_222_222)
    end
  end
end
