class Api::V1::CustomersTransactionsController < ApplicationController
  def index
    respond_with Customer.find_by(id: params['customer_id']).transactions
  end
end