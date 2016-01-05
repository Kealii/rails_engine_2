require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do

  let!(:invoice1) { FactoryGirl.create(:invoice) }

  describe 'GET #index' do
    it 'returns the correct number of invoices' do
      number_of_invoices = Invoice.count
      get :index, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_invoices
    end
  end

  describe 'GET #show' do
    it 'returns the correct invoice' do
      get :show, id: invoice1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq invoice1.id
      expect(json_response['status']).to eq invoice1.status
    end
  end

  describe 'GET #find' do
    it 'returns the correct invoice by id' do
      get :find, id: invoice1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq invoice1.id
      expect(json_response['status']).to eq invoice1.status
    end

    it 'returns an invoice by customer id' do
      get :find, customer_id: invoice1.customer_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response['customer_id']).to eq invoice1.customer_id
    end

    it 'returns an invoice by merchant id' do
      get :find, merchant_id: invoice1.merchant_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response['merchant_id']).to eq invoice1.merchant_id
    end

    it 'returns an invoice by status' do
      get :find, status: invoice1.status, format: :json

      expect(response).to have_http_status :success
      expect(json_response['status']).to eq invoice1.status
    end
  end
end
