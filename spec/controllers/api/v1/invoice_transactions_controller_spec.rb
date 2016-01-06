require 'rails_helper'

describe Api::V1::InvoiceTransactionsController do
  describe '#index' do
    it 'returns all transactions for an invoice' do
      invoice = FactoryGirl.create(:invoice)
      transaction1 = FactoryGirl.create(:transaction, invoice: invoice)
      transaction2 = FactoryGirl.create(:transaction, invoice: invoice)
      FactoryGirl.create(:transaction)

      get :index, invoice_id: invoice.id

      expect(json_response).to match([
        a_hash_including({'id' => transaction1.id}),
        a_hash_including({'id' => transaction2.id})
      ])

    end
  end
end