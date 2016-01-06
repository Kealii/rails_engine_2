class Api::V1::InvoiceTransactionsController < ApplicationController
  def index
    respond_with Invoice.find(params[:invoice_id]).transactions
  end
end