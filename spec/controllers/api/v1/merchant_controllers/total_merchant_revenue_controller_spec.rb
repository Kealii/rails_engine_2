require 'rails_helper'

RSpec.describe Api::V1::TotalMerchantRevenueController, type: :controller do

  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }
  let!(:merchant3) { create(:merchant, name: 'Different Merchant') }

  def revenue_setup
    create_items(merchant1, 'success', 4)
    create_items(merchant1, 'failed',  4)
    create_items(merchant2, 'success', 3)
  end

  def create_items(merchant, result, quantity)
    item    = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant)
    create(:invoice_item, item: item, quantity: quantity, invoice: invoice)
    create(:transaction, result: result, invoice: invoice )
  end

  describe '#index' do
    it 'returns the total revenue across all merchants for a specific date' do
      revenue_setup
      get :index, date: merchant1.items.first.created_at

      expect(json_response['total_revenue']).to eq '0.0'
    end
  end
end
