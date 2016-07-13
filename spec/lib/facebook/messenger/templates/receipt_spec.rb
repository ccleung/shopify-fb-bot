require 'rails_helper'

RSpec.describe Fb::Messenger::Template::Receipt do
  context '#template' do
    let(:receipt_item) { Fb::Messenger::Template::ReceiptItem.new }

    before(:each) do
      subject.receipt_items << receipt_item
    end

    it 'contains the proper attributes' do
      expect(subject.template).to include(:attachment)
    end

    context 'attachments key' do
      it 'contains the proper attributes' do
        expect(subject.template[:attachment]).to include(:type, :payload)
      end

      it 'sets type to template' do
        expect(subject.template[:attachment][:type]).to eq('template')
      end
    end

    context 'payload key' do
      it 'contains the proper attributes' do
        expect(subject.template[:attachment][:payload]).to include(:template_type, :recipient_name, :order_number,
                                                                   :currency, :payment_method, :order_url, :timestamp,
                                                                   :elements, :summary)
      end

      it 'sets template_type to receipt' do
        expect(subject.template[:attachment][:payload][:template_type]).to eq('receipt')
      end

      it 'defaults payment method to N/A' do
        expect(subject.template[:attachment][:payload][:payment_method]).to eq('N/A')
      end
    end

    context 'summary key' do
      it 'contains the proper attributes' do
        expect(subject.template[:attachment][:payload][:summary]).to include(:total_cost)
      end
    end

    context 'items' do
      it 'contains receipt item with proper attributes' do
        expect(subject.template[:attachment][:payload][:elements]).to eq([title: nil, subtitle: nil, quantity: nil,
                                                                          price: nil, currency: nil, image_url: nil])
      end
    end
  end

  context '#new' do
    let(:opts) do
      {
        recipient_name: 'recipient_name',
        order_number: 'order_number',
        currency: 'currency',
        payment_method: 'payment_method',
        order_url: 'order_url',
        timestamp: 'timestamp',
        total_cost: 'total_cost'
      }
    end

    subject { Fb::Messenger::Template::Receipt.new(opts) }

    it 'initializes recipient_name value' do
      expect(subject.recipient_name).to eq('recipient_name')
    end

    it 'initializes order_number value' do
      expect(subject.order_number).to eq('order_number')
    end

    it 'initializes currency value' do
      expect(subject.currency).to eq('currency')
    end

    it 'initializes payment_method value' do
      expect(subject.payment_method).to eq('payment_method')
    end

    it 'initializes order_url value' do
      expect(subject.order_url).to eq('order_url')
    end

    it 'initializes timestamp value' do
      expect(subject.timestamp).to eq('timestamp')
    end

    it 'initializes total_cost value' do
      expect(subject.total_cost).to eq('total_cost')
    end

    it 'initializes receipt_items to empty' do
      expect(subject.receipt_items).to eq([])
    end
  end
end
