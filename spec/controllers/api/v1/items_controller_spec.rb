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
end
