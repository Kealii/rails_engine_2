require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do

  let!(:invoice_item1) { FactoryGirl.create(:invoice_item) }
  let!(:invoice_item2) { FactoryGirl.create(:invoice_item,
                                            item:    invoice_item1.item,
                                            invoice: invoice_item1.invoice) }
  let!(:invoice_item3) { FactoryGirl.create(:invoice_item,
                                            quantity:   1,
                                            unit_price: 54321) }

  describe 'GET #index' do
    it 'returns the correct number of invoice items' do
      number_of_invoice_items = InvoiceItem.count
      get :index

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_invoice_items
    end
  end

  describe 'GET #show' do
    it 'returns the correct invoice item' do
      get :show, id: invoice_item1.id

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq invoice_item1.id
      expect(json_response['quantity']).to eq invoice_item1.quantity
      expect(json_response['unit_price']).to eq invoice_item1.unit_price.to_s
    end
  end

  describe 'GET #find' do
    it 'returns the correct invoice item by id' do
      get :find, id: invoice_item1.id

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq invoice_item1.id
      expect(json_response['quantity']).to eq invoice_item1.quantity
      expect(json_response['unit_price']).to eq invoice_item1.unit_price.to_s
    end

    it 'returns an invoice item by item id' do
      get :find, item_id: invoice_item1.item_id

      expect(response).to have_http_status :success
      expect(json_response['item_id']).to eq invoice_item1.item_id
    end

    it 'returns an invoice item by invoice id' do
      get :find, invoice_id: invoice_item1.invoice_id

      expect(response).to have_http_status :success
      expect(json_response['invoice_id']).to eq invoice_item1.invoice_id
    end

    it 'returns an invoice item by quantity' do
      get :find, quantity: invoice_item1.quantity

      expect(response).to have_http_status :success
      expect(json_response['quantity']).to eq invoice_item1.quantity
    end

    it 'returns an invoice item by unit price' do
      get :find, unit_price: invoice_item1.unit_price

      expect(response).to have_http_status :success
      expect(json_response['unit_price']).to eq invoice_item1.unit_price.to_s
    end
  end

  describe 'GET #find_all' do
    it 'returns all invoice items by item id' do
      get :find_all, item_id: invoice_item1.item_id

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['item_id']).to eq invoice_item1.item_id
    end

    it 'returns all invoice items by invoice id' do
      get :find_all, invoice_id: invoice_item1.invoice_id

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['invoice_id']).to eq invoice_item1.invoice_id
    end

    it 'returns all invoice items by quantity' do
      get :find_all, quantity: invoice_item1.quantity

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['quantity']).to eq invoice_item1.quantity
    end

    it 'returns all invoice items by unit price' do
      get :find_all, unit_price: invoice_item1.unit_price

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['unit_price']).to eq invoice_item1.unit_price.to_s
    end
  end

  describe 'GET #random' do
    it 'returns a random invoice item' do
      get :random

      expect(response).to have_http_status :success
      expect(json_response.first['id']).to_not eq nil
    end
  end
end