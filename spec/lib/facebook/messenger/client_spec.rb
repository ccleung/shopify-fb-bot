require 'rails_helper'

RSpec.describe Fb::Messenger::Client do
  subject { Fb::Messenger::Client }

  let(:access_token) { 'fb_access_token' }

  before(:each) do
    Fb::Messenger.config.access_token = access_token
  end

  describe '.send' do
    let(:payload) { { test: { foo: 'bar' } } }

    it 'sends facebook messenger API request with access token' do
      expect(RestClient).to receive(:post)
        .with('https://graph.facebook.com/v2.6/me/messages?access_token=fb_access_token',
              anything, anything)
      subject.send(payload)
    end

    it 'sends payload as json' do
      expect(RestClient).to receive(:post)
        .with(anything, %({"test":{"foo":"bar"}}), anything)
      subject.send(payload)
    end

    it 'sets content_type and accept headers' do
      expect(RestClient).to receive(:post)
        .with(anything, anything, content_type: :json, accept: :json)
      subject.send(payload)
    end
  end

  describe '.user_info' do
    let(:user_id) { 1234 }

    before(:each) do
      stub_request(:get, %r{https://graph.facebook.com/v2.6/*})
        .to_return(body: { foo: 'bar' }.to_json)
    end

    it 'sends get request to facebook graph API' do
      expect(RestClient).to receive(:get)
        .with('https://graph.facebook.com/v2.6/1234', anything).and_call_original
      subject.user_info(user_id)
    end

    it 'sets access token in params and accept json' do
      expect(RestClient).to receive(:get)
        .with(anything, params: { access_token: 'fb_access_token' }, accept: :json).and_call_original
      subject.user_info(user_id)
    end
  end
end
