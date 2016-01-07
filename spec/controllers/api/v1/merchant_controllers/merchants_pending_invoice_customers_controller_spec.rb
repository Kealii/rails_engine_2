require 'rails_helper'

RSpec.describe Api::V1::MerchantsPendingInvoiceCustomersController, type: :controller do

  let!(:merchant)  { create(:merchant) }
  let!(:customer1) { create(:customer) }
  let!(:customer2) { create(:customer) }
  let!(:customer3) { create(:customer) }

  def customer_setup
    item    = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer1)
    create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    create(:transaction, result: 'success', invoice: invoice)

    invoice = create(:invoice, merchant: merchant, customer: customer2)
    create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    create(:transaction, result: 'failed', invoice: invoice)

    invoice = create(:invoice, merchant: merchant, customer: customer3)
    create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    create(:transaction, result: 'failed', invoice: invoice)
  end

  describe '#index' do
    it 'returns all customers with pending invoices for a merchant' do
      customer_setup
      get :index, merchant_id: merchant.id

      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
    end
  end
end
