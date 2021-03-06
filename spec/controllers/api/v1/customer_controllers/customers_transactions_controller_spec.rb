require 'rails_helper'

RSpec.describe Api::V1::CustomersTransactionsController, type: :controller do

  describe '#index' do
    it 'returns the transactions of the customer' do
      customer    = create(:customer)
      invoice     = create(:invoice, customer: customer)
      transaction = create(:transaction, invoice: invoice)
      create(:transaction, invoice: invoice)
      create(:transaction)
      get :index, customer_id: customer.id

      expect(json_response.count).to eq 2
      expect(json_response.first['id']).to eq transaction.id
    end
  end

end