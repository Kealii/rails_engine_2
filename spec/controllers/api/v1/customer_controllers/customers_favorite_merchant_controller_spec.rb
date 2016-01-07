require 'rails_helper'

RSpec.describe Api::V1::CustomersFavoriteMerchantController, type: :controller do

  let!(:customer)  { FactoryGirl.create(:customer) }
  let!(:merchant1) { FactoryGirl.create(:merchant) }
  let!(:merchant2) { FactoryGirl.create(:merchant) }

  def merchant_setup
    item    = FactoryGirl.create(:item, merchant: merchant1)
    invoice = FactoryGirl.create(:invoice, merchant: merchant1, customer: customer)
    FactoryGirl.create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    FactoryGirl.create(:transaction, result: 'success', invoice: invoice)

    invoice = FactoryGirl.create(:invoice, merchant: merchant2, customer: customer)
    FactoryGirl.create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    FactoryGirl.create(:transaction, result: 'expired', invoice: invoice)
  end

  describe '#index' do
    it 'returns the merchant with the most successful transactions for a customer' do
      merchant_setup
      get :index, customer_id: customer.id

      expect(json_response['id']).to eq merchant1.id
    end
  end
end
