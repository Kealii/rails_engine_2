class Api::V1::InvoiceCustomerController < ApplicationController
  def index
    respond_with Invoice.find_by(id: params[:invoice_id]).customer
  end
end