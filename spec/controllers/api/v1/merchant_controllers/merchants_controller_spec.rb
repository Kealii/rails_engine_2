require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do

  let!(:merchant1) { FactoryGirl.create(:merchant) }
  let!(:merchant2) { FactoryGirl.create(:merchant) }
  let!(:merchant3) { FactoryGirl.create(:merchant,
                                        name: 'Different Merchant') }

  def revenue_setup
    item         = FactoryGirl.create(:item, merchant: merchant1)
    invoice      = FactoryGirl.create(:invoice, merchant: merchant1)
    FactoryGirl.create(:invoice_item, item: item, quantity: 3, unit_price: 2, invoice: invoice)
    FactoryGirl.create(:transaction, result: 'success', invoice: invoice)

    invoice = FactoryGirl.create(:invoice, merchant: merchant1)
    FactoryGirl.create(:invoice_item, item: item, quantity: 3, unit_price: 2, invoice: invoice)
    FactoryGirl.create(:transaction, result: 'expired', invoice: invoice)

    invoice = FactoryGirl.create(:invoice, merchant: merchant2)
    FactoryGirl.create(:invoice_item, item: item, quantity: 3, unit_price: 2, invoice: invoice)
    FactoryGirl.create(:transaction, result: 'success', invoice: invoice)
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

      expect(json_response['revenue']).to eq '0.06'
    end
  end

  describe 'GET #revenue_by_date' do
    it 'returns the revenue for a merchant for a specific date' do
      revenue_setup
      get :revenue, merchant_id: merchant1.id, date: merchant1.created_at

      expect(json_response['revenue']).to eq '0.0'
    end
  end
end
