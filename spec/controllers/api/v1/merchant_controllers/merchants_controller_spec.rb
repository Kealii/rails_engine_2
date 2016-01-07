require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do

  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }
  let!(:merchant3) { create(:merchant,
                                        name: 'Different Merchant') }

  def revenue_setup
    item         = create(:item, merchant: merchant1)
    invoice      = create(:invoice, merchant: merchant1)
    create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    create(:transaction, result: 'success', invoice: invoice)

    invoice = create(:invoice, merchant: merchant1)
    create(:invoice_item, item: item, quantity: 3, unit_price: 2, invoice: invoice)
    create(:transaction, result: 'expired', invoice: invoice)

    invoice = create(:invoice, merchant: merchant2)
    create(:invoice_item, item: item, quantity: 3, unit_price: 2, invoice: invoice)
    create(:transaction, result: 'success', invoice: invoice)
  end

  def items_sold_setup
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)
    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)
    create(:invoice_item, item: item1, quantity: 4, unit_price: 2, invoice: invoice1)
    create(:invoice_item, item: item2, quantity: 3, unit_price: 2, invoice: invoice2)
    create(:transaction, result: 'success', invoice: invoice1)
    create(:transaction, result: 'success', invoice: invoice2)
  end

  describe 'GET #index' do
    it 'returns the correct number of merchants' do
      number_of_merchants = Merchant.count
      get :index

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_merchants
    end
  end

  describe 'GET #show' do
    it 'returns the correct merchant' do
      get :show, id: merchant1.id

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq merchant1.id
      expect(json_response['name']).to eq merchant1.name
    end
  end

  describe 'GET #find' do
    it 'returns the correct merchant by id' do
      get :find, id: merchant1.id

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq merchant1.id
    end

    it 'returns the correct merchant by name' do
      get :find, name: merchant1.name

      expect(response).to have_http_status :success
      expect(json_response['name']).to eq merchant1.name
    end
  end

  describe 'GET #find_all' do
    it 'returns all merchants by name' do
      get :find_all, name: merchant1.name

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['name']).to eq merchant1.name
    end
  end

  describe 'GET #random' do
    it 'returns a random merchant' do
      get :random

      expect(response).to have_http_status :success
      expect(json_response.first['id']).to_not eq nil
    end
  end

  describe 'GET #revenue' do
    it 'returns the total revenue for a merchant' do
      revenue_setup
      get :revenue, merchant_id: merchant1.id

      expect(json_response['revenue']).to eq '0.08'
    end
  end

  describe 'GET #revenue_by_date' do
    it 'returns the revenue for a merchant for a specific date' do
      revenue_setup
      get :revenue, merchant_id: merchant1.id, date: merchant1.created_at

      expect(json_response['revenue']).to eq '0.0'
    end
  end

  describe 'GET #most_revenue' do
    it 'returns the top merchants ranked by total revenue' do
      revenue_setup

      get :most_revenue, quantity: 2
      expect(json_response.count).to eq 2
      expect(json_response.first['id']).to eq merchant1.id
    end
  end

  describe 'GET #most_items' do
    it 'returns the top merchants ranked by total items sold' do
      items_sold_setup

      get :most_items, quantity: 2
      expect(json_response.count).to eq 2
      expect(json_response.first['id']).to eq merchant1.id
    end
  end

end
