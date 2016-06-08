require 'rails_helper'

RSpec.describe Facebook::Messenger::Receiver do
  subject { Facebook::Messenger::Receiver }

  describe '.receive' do
    let(:fb_msg_event) { build(:fb_msg_event) }

    it 'maps event' do
      fb_msg_event
    end
  end

  describe '.subscribe' do
  end
end
