require 'rails_helper'

describe Api::V1::InvoiceItemsInvoiceController do

  describe '#index' do
    it 'returns the invoice for an invoice item' do
      FactoryGirl.create(:invoice)
      invoice = FactoryGirl.create(:invoice)
      invoice_item = FactoryGirl.create(:invoice_item, invoice: invoice)
      get :index, invoice_item_id: invoice_item.id

      expect(json_response.class).to eq Hash
      expect(json_response['id']).to eq invoice.id
    end
  end
end