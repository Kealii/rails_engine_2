require 'rails_helper'

describe Api::V1::MerchantItemsController, type: :controller do

  describe '#index' do
    it 'returns the items of the merchant' do
      merchant = create(:merchant)
      create(:item, merchant: merchant)
      create(:item, merchant: merchant)
      create(:item)

      get :index, merchant_id: merchant.id
      expect(json_response.count).to eq 2
      expect(json_response.first['merchant_id']).to eq merchant.id
    end
  end
end