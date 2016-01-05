class Api::V1::CustomersController < ApplicationController
  def index
    respond_with :api, :v1, Customer.all
  end

  def show
    respond_with :api, :v1, Customer.find(params[:id])
  end
end
