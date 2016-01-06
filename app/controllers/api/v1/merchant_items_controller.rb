module Api
  module V1
    class MerchantItemsController < ApplicationController
      def index
        merchant = Merchant.find_by(id: params[:merchant_id])
        if merchant
          respond_with merchant.items.to_json
        else
          respond_with nil, status: :not_found
        end
      end
    end
  end
end