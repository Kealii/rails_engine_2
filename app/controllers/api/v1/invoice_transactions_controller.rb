module Api
  module V1
    class InvoiceTransactionsController < ApplicationController
      def index
        respond_with Invoice.find(params[:invoice_id]).transactions
      end
    end
  end
end