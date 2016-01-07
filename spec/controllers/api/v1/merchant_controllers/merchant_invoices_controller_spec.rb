require 'rails_helper'

RSpec.describe Api::V1::MerchantInvoicesController, type: :controller do

  describe '#index' do
    it 'returns the invoices of the merchant' do
      merchant = FactoryGirl.create(:merchant)
      FactoryGirl.create(:invoice, merchant: merchant)
      FactoryGirl.create(:invoice, merchant: merchant)
      FactoryGirl.create(:invoice)

      get :index, merchant_id: merchant.id
      expect(json_response.count).to eq 2
      expect(json_response.first['merchant_id']).to eq merchant.id

    end
  end

end