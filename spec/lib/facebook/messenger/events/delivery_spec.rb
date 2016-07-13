require 'rails_helper'

RSpec.describe Fb::Messenger::Event::Delivery do
  let(:event_data) { build(:fb_msg_event, :delivery) }
  subject { Fb::Messenger::Event::Delivery.new(event_data) }

  context '#watermark' do
    it 'returns watermark' do
      expect(subject.watermark).to eq(1_458_668_856_253)
    end
  end

  context '#mids' do
    it 'returns mids' do
      expect(subject.mids).to eq(['mid.1458668856218:ed81099e15d3f4f233'])
    end
  end

  context '#seq' do
    it 'returns seq' do
      expect(subject.seq).to eq(37)
    end
  end
end
