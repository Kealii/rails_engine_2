class Api::V1::MerchantInvoicesController < ApplicationController
  def index
    respond_with Merchant.find_by(id: params[:merchant_id]).invoices
  end
end