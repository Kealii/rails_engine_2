require 'rails_helper'

describe Api::V1::InvoiceCustomerController do

  describe '#index' do
    it 'returns the customer for an invoice' do
      create(:customer)
      customer = create(:customer)
      invoice  = create(:invoice, customer: customer)
      get :index, invoice_id: invoice.id

      expect(json_response.class).to eq Hash
      expect(json_response['id']).to eq customer.id
    end
  end
end