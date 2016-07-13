require 'rails_helper'

RSpec.describe Fb::Messenger::Event::Message do
  let(:event_data) { build(:fb_msg_event, :message) }
  subject { Fb::Messenger::Event::Message.new(event_data) }

  context '#text' do
    it 'returns text' do
      expect(subject.text).to eq('hello')
    end
  end

  context '#mid' do
    it 'returns mid' do
      expect(subject.mid).to eq('mid.1460245671959:dad2ec9421b03d6f78')
    end
  end

  context '#seq' do
    it 'returns seq' do
      expect(subject.seq).to eq(216)
    end
  end
end
