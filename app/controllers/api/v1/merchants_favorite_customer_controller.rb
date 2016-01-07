class Api::V1::MerchantsFavoriteCustomerController < ApplicationController
  def index
    respond_with Merchant.find_by(id: params[:merchant_id]).favorite_customer
  end
end