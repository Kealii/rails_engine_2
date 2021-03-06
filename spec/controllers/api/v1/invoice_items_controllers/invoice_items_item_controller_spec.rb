require 'rails_helper'

describe Api::V1::InvoiceItemsItemController do

  describe '#index' do
    it 'returns the item for an invoice item' do
      create(:item)
      item = create(:item)
      invoice_item = create(:invoice_item, item: item)
      get :index, invoice_item_id: invoice_item.id

      expect(json_response.class).to eq Hash
      expect(json_response['id']).to eq item.id
    end
  end
end