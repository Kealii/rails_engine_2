require 'rails_helper'

describe Api::V1::InvoiceTransactionsController do

  describe '#index' do
    it 'returns all transactions for an invoice' do
      invoice = create(:invoice)
      create(:transaction, invoice: invoice)
      create(:transaction, invoice: invoice)
      create(:transaction)
      get :index, invoice_id: invoice.id

      expect(json_response.count).to eq 2
      expect(json_response.first['invoice_id']).to eq invoice.id
    end
  end
end