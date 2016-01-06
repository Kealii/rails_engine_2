class Api::V1::InvoicesItemsController < ApplicationController
  def index
    respond_with Invoice.find_by(id: params[:invoice_id]).items
  end
end