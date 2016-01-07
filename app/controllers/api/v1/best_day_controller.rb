class Api::V1::BestDayController < ApplicationController
  def index
    respond_with Item.find_by(id: params[:item_id]).best_day
  end
end