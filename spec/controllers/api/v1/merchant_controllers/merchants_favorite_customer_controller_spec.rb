require 'rails_helper'

RSpec.describe Api::V1::MerchantsFavoriteCustomerController, type: :controller do

  let!(:merchant)  { create(:merchant) }
  let!(:customer1) { create(:customer) }
  let!(:customer2) { create(:customer) }

  def customer_setup
    create_transactions(customer1, 'success')
    create_transactions(customer2, 'expired')
  end

  def create_transactions(customer, result)
    item    = create(:item,    merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create(:invoice_item, item: item,     invoice: invoice)
    create(:transaction,  result: result, invoice: invoice)
  end

  describe '#index' do
    it 'returns the customer with the most successful transactions with a merchant' do
      customer_setup
      get :index, merchant_id: merchant.id

      expect(json_response['id']).to eq customer1.id
    end
  end
end
