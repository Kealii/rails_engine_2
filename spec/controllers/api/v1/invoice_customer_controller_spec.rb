require 'rails_helper'

describe Api::V1::InvoiceCustomerController do

  describe '#index' do
    it 'returns the customer for an invoice' do
      FactoryGirl.create(:customer)
      customer = FactoryGirl.create(:customer)
      invoice   = FactoryGirl.create(:invoice, customer: customer)
      get :index, invoice_id: invoice.id

      expect(json_response.class).to eq Hash
      expect(json_response['id']).to eq customer.id
    end
  end
end