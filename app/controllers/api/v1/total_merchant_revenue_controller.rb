class Api::V1::TotalMerchantRevenueController < ApplicationController
  def index
    respond_with Merchant.total_revenue_by_date(merchant_params[:date])
  end

  private

  def merchant_params
    params.permit(:date)
  end
end