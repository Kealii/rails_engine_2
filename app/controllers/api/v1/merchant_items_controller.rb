class Api::V1::MerchantItemsController < ApplicationController
  def index
    respond_with Merchant.find_by(id: params[:merchant_id]).items
  end
end