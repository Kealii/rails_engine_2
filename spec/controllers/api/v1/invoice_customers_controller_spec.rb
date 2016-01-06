require 'rails_helper'

describe Api::V1::InvoiceCustomersController do

  describe '#index' do
    it 'returns the customer for an invoice' do
      customer1 = FactoryGirl.create(:customer)
      FactoryGirl.create(:customer)
      invoice   = FactoryGirl.create(:invoice, customer: customer1)
      get :index, invoice_id: invoice.id

      expect(json_response.class).to eq Hash
      expect(json_response['id']).to eq customer1.id
    end
  end
end