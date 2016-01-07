class Api::V1::MerchantsController < ApplicationController
  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find(params[:id])
  end

  def find
    respond_with Merchant.find_by(merchant_params)
  end

  def find_all
    respond_with Merchant.where(merchant_params)
  end

  def random
    respond_with Merchant.limit(1).order('RANDOM()')
  end

  def revenue
    respond_with Merchant.find(params[:merchant_id]).revenue(merchant_params)
  end

  def most_revenue
    respond_with Merchant.revenue_ranking(merchant_params[:quantity])
  end

  def most_items
    respond_with Merchant.item_ranking(merchant_params[:quantity])
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at, :date, :quantity)
  end
end
