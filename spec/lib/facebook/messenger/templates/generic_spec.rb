require 'rails_helper'

RSpec.describe Facebook::Messenger::Template::Generic do
  context '#template' do
    let(:generic_item) { Facebook::Messenger::Template::GenericItem.new }

    before(:each) do
      subject.generic_items << generic_item
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
        expect(subject.template[:attachment][:payload]).to include(:template_type, :elements)
      end

      it 'sets template_type to generic' do
        expect(subject.template[:attachment][:payload][:template_type]).to eq('generic')
      end
    end

    context 'generic items' do
      it 'contains generic item with proper attributes' do
        expect(subject.template[:attachment][:payload][:elements]).to eq([title: nil, subtitle: nil, image_url: nil,
                                                                          buttons: []])
      end
    end
  end
end
