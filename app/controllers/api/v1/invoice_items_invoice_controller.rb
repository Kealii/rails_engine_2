class Api::V1::InvoiceItemsInvoiceController < ApplicationController
  def index
    respond_with InvoiceItem.find_by(id: params['invoice_item_id']).invoice
  end
end