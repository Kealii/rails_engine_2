class Api::V1::ItemsController < ApplicationController
  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find(params[:id])
  end

  def find
    respond_with Item.find_by(item_params)
  end

  def find_all
    respond_with Item.where(item_params)
  end

  def random
    respond_with Item.limit(1).order('RANDOM()')
  end

  def most_revenue
    respond_with Item.revenue_ranking(item_params[:quantity])
  end

  def most_items
    respond_with Item.item_ranking(item_params[:quantity])
  end

  private

  def item_params
    params.permit(:id,
                  :name,
                  :description,
                  :unit_price,
                  :merchant_id,
                  :quantity,
                  :created_at,
                  :updated_at)
  end
end
