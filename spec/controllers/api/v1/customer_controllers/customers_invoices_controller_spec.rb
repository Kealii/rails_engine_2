require 'rails_helper'

RSpec.describe Api::V1::CustomersInvoicesController, type: :controller do

  describe '#index' do
    it 'returns the invoices of the customer' do
      customer = FactoryGirl.create(:customer)
      invoice  = FactoryGirl.create(:invoice, customer: customer)
      FactoryGirl.create(:invoice, customer: customer)
      FactoryGirl.create(:invoice)
      get :index, customer_id: customer.id

      expect(json_response.count).to eq 2
      expect(json_response.first['id']).to eq invoice.id
    end
  end

end