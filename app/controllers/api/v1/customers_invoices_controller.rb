class Api::V1::CustomersInvoicesController < ApplicationController
  def index
    respond_with Customer.find_by(id: params['customer_id']).invoices
  end
end