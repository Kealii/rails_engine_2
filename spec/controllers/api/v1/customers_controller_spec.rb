require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do

  let!(:customer1) { FactoryGirl.create(:customer) }

  describe 'GET #index' do
    it 'returns the correct number of customers' do
      number_of_customers =  Customer.count
      get :index, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_customers
    end
  end

  describe 'GET #show' do
    it 'returns the correct customer' do
      get :show, id: customer1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["first_name"]).to eq customer1.first_name
      expect(json_response["last_name"]).to eq customer1.last_name
    end
  end
end
