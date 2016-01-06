class Api::V1::TransactionsInvoiceController < ApplicationController
  def index
    respond_with Transaction.find_by(id: params['transaction_id']).invoice
  end
end