require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do

  let!(:merchant1) { FactoryGirl.create(:merchant) }

  describe 'GET #index' do
    it 'returns the correct number of merchants' do
      number_of_merchants = Merchant.count
      get :index, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_merchants
    end
  end

  describe 'GET #show' do
    it 'returns the correct merchant' do
      get :show, id: merchant1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq merchant1.id
      expect(json_response['name']).to eq merchant1.name
    end
  end

  describe 'GET #find' do
    it 'returns the correct merchant by id' do
      get :find, id: merchant1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq merchant1.id
    end

    it 'returns the correct merchant by name' do
      get :find, name: merchant1.name, format: :json

      expect(response).to have_http_status :success
      expect(json_response['name']).to eq merchant1.name
    end
  end
end
