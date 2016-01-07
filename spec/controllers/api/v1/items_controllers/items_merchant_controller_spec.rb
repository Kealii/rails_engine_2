require 'rails_helper'

RSpec.describe Api::V1::ItemsMerchantController, type: :controller do

  describe '#index' do
    it 'returns the merchant of the item' do
      create(:merchant)
      merchant = create(:merchant)
      item     = create(:item, merchant: merchant)
      get :index, item_id: item.id

      expect(json_response.class).to eq Hash
      expect(json_response['id']).to eq merchant.id
    end
  end

end