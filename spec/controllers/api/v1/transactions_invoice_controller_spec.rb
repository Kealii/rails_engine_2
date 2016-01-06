require 'rails_helper'

RSpec.describe Api::V1::TransactionsInvoiceController, type: :controller do

  describe '#index' do
    it 'returns the invoice of the transaction' do
      invoice     = FactoryGirl.create(:invoice)
      transaction = FactoryGirl.create(:transaction, invoice: invoice)
      get :index, transaction_id: transaction.id

      puts json_response
      expect(json_response.class).to eq Hash
      expect(json_response['id']).to eq invoice.id
    end
  end

end