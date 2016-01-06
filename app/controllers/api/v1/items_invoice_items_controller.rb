class Api::V1::ItemsInvoiceItemsController < ApplicationController
  def index
    respond_with Item.find_by(id: params[:item_id]).invoice_items
  end
end