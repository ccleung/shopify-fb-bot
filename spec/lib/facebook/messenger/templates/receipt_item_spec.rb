require 'rails_helper'

RSpec.describe Fb::Messenger::Template::ReceiptItem do
  context '#template' do
    it 'contains the proper attributes' do
      expect(subject.template).to include(:title, :subtitle, :quantity, :price, :currency, :image_url)
    end
  end
end
