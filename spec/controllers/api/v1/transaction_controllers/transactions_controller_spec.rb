require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do

  let!(:transaction1) { create(:transaction) }
  let!(:transaction2) { create(:transaction,
                                           invoice: transaction1.invoice) }
  let!(:transaction3) { create(:transaction,
                                           credit_card_number: '1234',
                                           result: 'pending') }

  describe 'GET #index' do
    it 'returns the correct number of transactions' do
      number_of_transactions = Transaction.count
      get :index

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_transactions
    end
  end

  describe 'GET #show' do
    it 'returns the correct transaction' do
      get :show, id: transaction1.id

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq transaction1.id
      expect(json_response['credit_card_number']).to eq transaction1.credit_card_number
      expect(json_response['result']).to eq transaction1.result
    end
  end

  describe 'GET #find' do
    it 'returns the correct transaction by id' do
      get :find, id: transaction1.id

      expect(response).to have_http_status :success
      expect(json_response['id']).to eq transaction1.id
    end

    it 'returns a valid transaction by invoice id' do
      get :find, invoice_id: transaction1.invoice_id

      expect(response).to have_http_status :success
      expect(json_response['invoice_id']).to eq transaction1.invoice_id
    end

    it 'returns a valid transaction by credit card number' do
      get :find, credit_card_number: transaction1.credit_card_number

      expect(response).to have_http_status :success
      expect(json_response['credit_card_number']).to eq transaction1.credit_card_number
    end

    it 'returns a valid transaction by result' do
      get :find, result: transaction1.result

      expect(response).to have_http_status :success
      expect(json_response['result']).to eq transaction1.result
    end
  end

  describe 'GET #find_all' do
    it 'returns all transactions by invoice id' do
      get :find_all, invoice_id: transaction1.invoice_id

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['invoice_id']).to eq transaction1.invoice_id
    end

    it 'returns all transactions by credit card number' do
      get :find_all, credit_card_number: transaction1.credit_card_number

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['credit_card_number']).to eq transaction1.credit_card_number
    end

    it 'returns all transactions by result' do
      get :find_all, result: transaction1.result

      expect(response).to have_http_status :success
      expect(json_response.class).to eq Array
      expect(json_response.count).to eq 2
      expect(json_response.first['result']).to eq transaction1.result
    end
  end

  describe 'GET #random' do
    it 'returns a random transaction' do
      get :random

      expect(response).to have_http_status :success
      expect(json_response.first['id']).to_not eq nil
    end
  end
end
