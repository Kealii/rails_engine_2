require 'rails_helper'

describe Api::V1::MerchantItemsController do
  describe '#index' do
    it 'returns the items of the merchant' do
      merchant = FactoryGirl.create(:merchant)
      item1 = FactoryGirl.create(:item, merchant: merchant)
      item2 = FactoryGirl.create(:item, merchant: merchant)
      FactoryGirl.create(:item)

      get :index, merchant_id: merchant.id
      expect(json_response).to match([
          a_hash_including({'id' => item1.id}),
          a_hash_including({'id' => item2.id})

                                     ])
    end

    it 'returns 404 with a bad merchant id' do
      get :index, merchant_id: 'not-a-real-id'
      expect(response).to have_http_status :not_found
    end
  end
end