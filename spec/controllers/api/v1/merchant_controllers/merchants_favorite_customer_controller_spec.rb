require 'rails_helper'

RSpec.describe Api::V1::MerchantsFavoriteCustomerController, type: :controller do

  let!(:merchant1) { create(:merchant) }
  let!(:customer1) { create(:customer) }

  def customer_setup
    item    = create(:item, merchant: merchant1)
    invoice = create(:invoice, merchant: merchant1, customer: customer1)
    create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    create(:transaction, result: 'success', invoice: invoice)

    customer2 = create(:customer)
    invoice = create(:invoice, merchant: merchant1, customer: customer2)
    create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    create(:transaction, result: 'expired', invoice: invoice)
  end

  describe '#index' do
    it 'returns the customer with the most successful transactions with a merchant' do
      customer_setup
      get :index, merchant_id: merchant1.id

      expect(json_response['id']).to eq customer1.id
    end
  end
end
