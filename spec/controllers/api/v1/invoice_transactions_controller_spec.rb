require 'rails_helper'

describe Api::V1::InvoiceTransactionsController do

  describe '#index' do
    it 'returns all transactions for an invoice' do
      invoice = FactoryGirl.create(:invoice)
      FactoryGirl.create(:transaction, invoice: invoice)
      FactoryGirl.create(:transaction, invoice: invoice)
      FactoryGirl.create(:transaction)
      get :index, invoice_id: invoice.id

      expect(json_response.count).to eq 2
    end
  end
end