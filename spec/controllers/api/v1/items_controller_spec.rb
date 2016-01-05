require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do

  let!(:item1) { FactoryGirl.create(:item) }

  describe 'GET #index' do
    it 'returns the correct number of items' do
      number_of_items = Item.count
      get :index, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_items
    end
  end

  describe 'GET #show' do
    it 'returns the correct item' do
      get :show, id: item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq item1.id
      expect(json_response['name']).to eq item1.name
      expect(json_response['description']).to eq item1.description
    end
  end

  describe 'GET #find' do
    it 'returns the correct item by id' do
      get :find, id: item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq item1.id
    end

    it 'returns an item by name' do
      get :find, name: item1.name, format: :json

      expect(response).to have_http_status :success
      expect(json_response['name']).to eq item1.name
    end

    it 'returns an item by description' do
      get :find, description: item1.description, format: :json

      expect(response).to have_http_status :success
      expect(json_response['description']).to eq item1.description
    end

    it 'returns an item by unit price' do
      get :find, unit_price: item1.unit_price, format: :json

      expect(response).to have_http_status :success
      expect(json_response['unit_price']).to eq item1.unit_price.to_s
    end

    it 'returns an item by merchant id' do
      get :find, merchant_id: item1.merchant_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response['merchant_id']).to eq item1.merchant_id
    end
  end
end
