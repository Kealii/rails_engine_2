class Api::V1::MerchantsPendingInvoiceCustomersController < ApplicationController
  def index
    respond_with Merchant.find_by(id: params[:merchant_id]).pending_customers
  end
end