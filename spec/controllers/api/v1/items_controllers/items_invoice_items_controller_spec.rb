require 'rails_helper'

RSpec.describe Api::V1::ItemsInvoiceItemsController, type: :controller do

  describe '#index' do
    it 'returns the invoice items of the item' do
      item = create(:item)
      create(:invoice_item, item: item)
      create(:invoice_item, item: item)
      create(:invoice_item)

      get :index, item_id: item.id
      expect(json_response.count).to eq 2
      expect(json_response.first['item_id']).to eq item.id
    end
  end

end