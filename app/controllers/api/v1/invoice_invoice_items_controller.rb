class Api::V1::InvoiceInvoiceItemsController < ApplicationController
  def index
    respond_with Invoice.find_by(id: params[:invoice_id]).invoice_items
  end
end