require 'rails_helper'

describe Api::V1::InvoiceInvoiceItemsController do

  describe '#index' do
    it 'returns all invoice items for an invoice' do
      invoice = FactoryGirl.create(:invoice)
      FactoryGirl.create(:invoice_item, invoice: invoice)
      FactoryGirl.create(:invoice_item, invoice: invoice)
      FactoryGirl.create(:invoice_item)
      get :index, invoice_id: invoice.id

      expect(json_response.count).to eq 2
      expect(json_response.first['invoice_id']).to eq invoice.id
    end
  end
end