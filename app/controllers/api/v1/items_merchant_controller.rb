class Api::V1::ItemsMerchantController < ApplicationController
  def index
    respond_with Item.find_by(id: params['item_id']).merchant
  end
end