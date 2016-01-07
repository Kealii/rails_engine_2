require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do

  let!(:merchant) { FactoryGirl.create(:merchant) }
  let!(:item1)    { FactoryGirl.create(:item, merchant: merchant) }
  let!(:item2)    { FactoryGirl.create(:item, merchant: merchant) }
  let!(:item3)    { FactoryGirl.create(:item,
                                       name: 'Different',
                                       description: 'Item',
                                       unit_price: 54321) }

  def revenue_setup
    create_item(item1, 'success')
    create_item(item2, 'failed')
    create_item(item1, 'success')
    create_item(item3, 'success')
  end

  def create_item(item, result)
    invoice = FactoryGirl.create(:invoice, merchant: merchant)
    FactoryGirl.create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    FactoryGirl.create(:transaction, result: result, invoice: invoice)
  end

  describe 'GET #index' do
    it 'returns the correct number of items' do
      number_of_items = Item.count
      get :index

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_items
    end
  end

  describe 'GET #show' do
    it 'returns the correct item' do
      get :show, id: item1.id

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq item1.id
      expect(json_response['name']).to eq item1.name
      expect(json_response['description']).to eq item1.description
    end
  end

  describe 'GET #find' do
    it 'returns the correct item by id' do
      get :find, id: item1.id

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq item1.id
    end

    it 'returns an item by name' do
      get :find, name: item1.name

      expect(response).to have_http_status :success
      expect(json_response['name']).to eq item1.name
    end

    it 'returns an item by description' do
      get :find, description: item1.description

      expect(response).to have_http_status :success
      expect(json_response['description']).to eq item1.description
    end

    it 'returns an item by unit price' do
      get :find, unit_price: item1.unit_price

      expect(response).to have_http_status :success
      expect(json_response['unit_price']).to eq item1.unit_price.to_s
    end

    it 'returns an item by merchant id' do
      get :find, merchant_id: item1.merchant_id

      expect(response).to have_http_status :success
      expect(json_response['merchant_id']).to eq item1.merchant_id
    end
  end

  describe 'GET #find_all' do
    it 'returns all items by name' do
      get :find_all, name: item1.name

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['name']).to eq item1.name
    end

    it 'returns all items by description' do
      get :find_all, description: item1.description

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['description']).to eq item1.description
    end

    it 'returns all items by unit price' do
      get :find_all, description: item1.description

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['unit_price']).to eq item1.unit_price.to_s
    end

    it 'returns all items by merchant id' do
      get :find_all, merchant_id: item1.merchant_id

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['merchant_id']).to eq item1.merchant_id
    end
  end

  describe 'GET #random' do
    it 'returns a random item' do
      get :random

      expect(response).to have_http_status :success
      expect(json_response.first['id']).to_not eq nil
    end
  end

  describe 'GET #most_revenue' do
    it 'returns the top items ranked by total revenue' do
      revenue_setup

      get :most_revenue, quantity: 2
      expect(json_response.count).to eq 2
      expect(json_response.first['id']).to eq item1.id
    end
  end

  describe 'GET #most_items' do
    it 'returns the top items ranked by number sold' do
      revenue_setup

      get :most_items, quantity: 2
      expect(json_response.count).to eq 2
      expect(json_response.first['id']).to eq item1.id
      expect(json_response.last['id']).to  eq item3.id
    end
  end

end
