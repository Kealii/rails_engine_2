class Api::V1::CustomersFavoriteMerchantController < ApplicationController
  def index
    respond_with Customer.find_by(id: params[:customer_id]).favorite_merchant
  end
end