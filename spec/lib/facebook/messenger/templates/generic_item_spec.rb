require 'rails_helper'

RSpec.describe Facebook::Messenger::Template::GenericItem do
  context '#template' do
    let(:button) { Facebook::Messenger::Template::Button.new(type: 'type', title: 'title', payload: 'payload') }

    before(:each) do
      subject.buttons << button
    end

    it 'contains the proper attributes' do
      expect(subject.template).to include(:title, :subtitle, :image_url, :buttons)
    end

    it 'contains the proper buttons' do
      expect(subject.template).to include(buttons: [{ type: 'type', title: 'title', payload: 'payload' }])
    end
  end

  context '#new' do
    let(:opts) do
      {
        title: 'title',
        subtitle: 'subtitle',
        image_url: 'image_url'
      }
    end

    subject { Facebook::Messenger::Template::GenericItem.new(opts) }

    it 'initializes title value' do
      expect(subject.title).to eq('title')
    end

    it 'initializes subtitle value' do
      expect(subject.subtitle).to eq('subtitle')
    end

    it 'initializes image_url value' do
      expect(subject.image_url).to eq('image_url')
    end
  end
end
