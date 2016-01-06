class Api::V1::InvoiceCustomersController < ApplicationController
  def index
    respond_with Invoice.find_by(id: params[:invoice_id]).customer
  end
end