require 'rails_helper'

RSpec.describe Api::V1::CustomersFavoriteMerchantController, type: :controller do

  let!(:customer)  { create(:customer) }
  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }

  def merchant_setup
    create_transactions(merchant1, 'success')
    create_transactions(merchant2, 'failed')
  end

  def create_transactions(merchant, result)
    item    = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create(:invoice_item, item: item, invoice: invoice)
    create(:transaction, result: result, invoice: invoice)
  end

  describe '#index' do
    it 'returns the merchant with the most successful transactions for a customer' do
      merchant_setup
      get :index, customer_id: customer.id

      expect(json_response['id']).to eq merchant1.id
    end
  end
end
