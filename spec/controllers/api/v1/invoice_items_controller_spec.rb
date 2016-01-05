require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do

  let!(:invoice_item1) { FactoryGirl.create(:invoice_item) }

  describe 'GET #index' do
    it 'returns the correct number of invoice items' do
      number_of_invoice_items = InvoiceItem.count
      get :index, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_invoice_items
    end
  end

  describe 'GET #show' do
    it 'returns the correct invoice item' do
      get :show, id: invoice_item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response['quantity']).to eq invoice_item1.quantity
      expect(json_response['unit_price']).to eq invoice_item1.unit_price.to_s
    end
  end


end
