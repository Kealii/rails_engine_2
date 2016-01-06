class Api::V1::InvoiceItemsItemController < ApplicationController
  def index
    respond_with InvoiceItem.find_by(id: params['invoice_item_id']).item
  end
end