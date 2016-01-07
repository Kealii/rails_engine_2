require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do

  let!(:customer1) { FactoryGirl.create(:customer) }
  let!(:customer2) { FactoryGirl.create(:customer) }
  let!(:customer3) { FactoryGirl.create(:customer,
                                        first_name: 'Different',
                                        last_name: 'Customer') }

  describe 'GET #index' do
    it 'returns the correct number of customers' do
      number_of_customers =  Customer.count
      get :index

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_customers
    end
  end

  describe 'GET #show' do
    it 'returns the correct customer' do
      get :show, id: customer1.id

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq customer1.id
      expect(json_response['first_name']).to eq customer1.first_name
      expect(json_response['last_name']).to  eq customer1.last_name
    end
  end

  describe 'GET #find' do
    it 'returns the correct customer by id' do
      get :find, id: customer1.id

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq customer1.id
      expect(json_response['first_name']).to eq customer1.first_name
    end

    it 'returns a customer by first name' do
      get :find, first_name: customer1.first_name

      expect(response).to have_http_status :success
      expect(json_response['first_name']).to eq customer1.first_name
    end

    it 'returns a customer by last name' do
      get :find, last_name: customer1.last_name

      expect(response).to have_http_status :success
      expect(json_response['last_name']).to eq customer1.last_name
    end
  end

  describe 'GET #find_all' do
    it 'returns all customers by first name' do
      get :find_all, first_name: customer1.first_name

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['first_name']).to eq customer2.first_name
    end

    it 'returns a customer by last name' do
      get :find_all, last_name: customer1.last_name

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['last_name']).to eq customer2.last_name
    end
  end

  describe 'GET #random' do
    it 'returns a random customer' do
      get :random

      expect(response).to have_http_status :success
      expect(json_response.first['id']).to_not eq nil
    end
  end
end
