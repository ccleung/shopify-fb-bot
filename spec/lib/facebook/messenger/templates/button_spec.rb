require 'rails_helper'

RSpec.describe Fb::Messenger::Template::Button do
  context '#type' do
    it 'can set type' do
      subject.type = 'postback'
      expect(subject.type).to eq('postback')
    end
  end

  context '#title' do
    it 'can set title' do
      subject.title = 'hello world'
      expect(subject.title).to eq('hello world')
    end
  end

  context '#payload' do
    it 'can set payload' do
      subject.payload = 'USER_PAYLOAD'
      expect(subject.payload).to eq('USER_PAYLOAD')
    end
  end

  context '#template' do
    it 'contains the proper attributes' do
      expect(subject.template).to include(:type, :title, :payload)
    end
  end
end
