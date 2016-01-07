require 'rails_helper'

RSpec.describe Api::V1::MerchantsPendingInvoiceCustomersController, type: :controller do

  let!(:merchant)  { FactoryGirl.create(:merchant) }
  let!(:customer1) { FactoryGirl.create(:customer) }
  let!(:customer2) { FactoryGirl.create(:customer) }
  let!(:customer3) { FactoryGirl.create(:customer) }

  def customer_setup
    item    = FactoryGirl.create(:item, merchant: merchant)
    invoice = FactoryGirl.create(:invoice, merchant: merchant, customer: customer1)
    FactoryGirl.create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    FactoryGirl.create(:transaction, result: 'success', invoice: invoice)

    invoice = FactoryGirl.create(:invoice, merchant: merchant, customer: customer2)
    FactoryGirl.create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    FactoryGirl.create(:transaction, result: 'failed', invoice: invoice)

    invoice = FactoryGirl.create(:invoice, merchant: merchant, customer: customer3)
    FactoryGirl.create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    FactoryGirl.create(:transaction, result: 'failed', invoice: invoice)
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
