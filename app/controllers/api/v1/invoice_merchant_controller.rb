class Api::V1::InvoiceMerchantController < ApplicationController
  def index
    respond_with Invoice.find_by(id: params['invoice_id']).merchant
  end
end