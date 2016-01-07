require 'rails_helper'

RSpec.describe Api::V1::ItemsMerchantController, type: :controller do

  describe '#index' do
    it 'returns the merchant of the item' do
      FactoryGirl.create(:merchant)
      merchant = FactoryGirl.create(:merchant)
      item     = FactoryGirl.create(:item, merchant: merchant)
      get :index, item_id: item.id

      expect(json_response.class).to eq Hash
      expect(json_response['id']).to eq merchant.id
    end
  end

end