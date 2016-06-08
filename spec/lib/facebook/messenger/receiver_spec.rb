require 'rails_helper'

RSpec.describe Facebook::Messenger::Receiver do
  subject { Facebook::Messenger::Receiver }

  describe '.receiver' do
    let(:message_subscriber) { Test::MessageSubscriber.new }
    let(:postback_subscriber) { Test::PostbackSubscriber.new }
    let(:delivery_subscriber) { Test::DeliverySubscriber.new }

    before(:each) do
      Facebook::Messenger::Receiver.configure do |receiver|
        receiver.subscribe 'message', message_subscriber
        receiver.subscribe 'postback', postback_subscriber
        receiver.subscribe 'delivery', delivery_subscriber
      end
    end

    let(:entry) do
      payload = build(:fb_payload)
      payload[:entry][0][:messaging] = [event]
      payload[:entry]
    end

    context 'message event' do
      let(:event) { build(:fb_msg_event, :message) }

      it 'invokes message subscriber' do
        expect(message_subscriber).to receive(:call)
          .with(kind_of(Facebook::Messenger::Event::Message), {})
        subject.receive(entry)
      end

      it 'does not invoke delivery subscriber' do
        expect(delivery_subscriber).to_not receive(:call)
        subject.receive(entry)
      end

      it 'does not invoke postback subscriber' do
        expect(postback_subscriber).to_not receive(:call)
        subject.receive(entry)
      end
    end

    context 'postback event' do
      let(:event) { build(:fb_msg_event, :postback) }

      it 'invokes postback subscriber' do
        expect(postback_subscriber).to receive(:call)
          .with(kind_of(Facebook::Messenger::Event::Postback), {})
        subject.receive(entry)
      end

      it 'does not invoke message subscriber' do
        expect(message_subscriber).to_not receive(:call)
        subject.receive(entry)
      end

      it 'does not invoke delivery subscriber' do
        expect(delivery_subscriber).to_not receive(:call)
        subject.receive(entry)
      end
    end

    context 'delivery event' do
      let(:event) { build(:fb_msg_event, :delivery) }

      it 'invokes delivery subscriber' do
        expect(delivery_subscriber).to receive(:call)
          .with(kind_of(Facebook::Messenger::Event::Delivery), {})
        subject.receive(entry)
      end

      it 'does not invoke message subscriber' do
        expect(message_subscriber).to_not receive(:call)
        subject.receive(entry)
      end

      it 'does not invoke postback subscriber' do
        expect(postback_subscriber).to_not receive(:call)
        subject.receive(entry)
      end
    end

    context 'unsupported event' do
      let(:event) do
        event = build(:fb_msg_event)
        event[:unsupported] = {}
        event
      end

      it 'logs error' do
        expect(subject).to receive(:handle_unsupported_event)
        subject.receive(entry)
      end

      it 'does not invoke message subscriber' do
        expect(message_subscriber).to_not receive(:call)
        subject.receive(entry)
      end

      it 'does not invoke postback subscriber' do
        expect(postback_subscriber).to_not receive(:call)
        subject.receive(entry)
      end

      it 'does not invoke delivery subscriber' do
        expect(delivery_subscriber).to_not receive(:call)
        subject.receive(entry)
      end
    end
  end
end
