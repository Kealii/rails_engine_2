require 'rails_helper'

describe Api::V1::InvoiceMerchantController do

  describe '#index' do
    it 'returns the merchant for an invoice' do
      FactoryGirl.create(:merchant)
      merchant = FactoryGirl.create(:merchant)
      invoice   = FactoryGirl.create(:invoice, merchant: merchant)
      get :index, invoice_id: invoice.id

      expect(json_response.class).to eq Hash
      expect(json_response['id']).to eq merchant.id
    end
  end
end