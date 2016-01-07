require 'rails_helper'

describe Api::V1::InvoicesItemsController do

  describe '#index' do
    it 'returns all items for an invoice' do
      invoice      = FactoryGirl.create(:invoice)
      item         = FactoryGirl.create(:item)
      invoice_item = FactoryGirl.create(:invoice_item, item: item, invoice: invoice)
      FactoryGirl.create(:invoice_item, item: item, invoice: invoice)
      FactoryGirl.create(:item)
      get :index, invoice_id: invoice.id

      expect(json_response.count).to eq 2
      expect(json_response.first['id']).to eq invoice_item.item_id
    end
  end
end