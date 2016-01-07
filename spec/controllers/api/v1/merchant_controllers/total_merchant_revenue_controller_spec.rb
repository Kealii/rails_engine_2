require 'rails_helper'

RSpec.describe Api::V1::TotalMerchantRevenueController, type: :controller do

  let!(:merchant1) { FactoryGirl.create(:merchant) }
  let!(:merchant2) { FactoryGirl.create(:merchant) }
  let!(:merchant3) { FactoryGirl.create(:merchant,
                                        name: 'Different Merchant') }

  def revenue_setup
    item         = FactoryGirl.create(:item, merchant: merchant1)
    invoice      = FactoryGirl.create(:invoice, merchant: merchant1)
    FactoryGirl.create(:invoice_item, item: item, quantity: 4, unit_price: 2, invoice: invoice)
    FactoryGirl.create(:transaction, result: 'success', invoice: invoice)

    invoice = FactoryGirl.create(:invoice, merchant: merchant1)
    FactoryGirl.create(:invoice_item, item: item, quantity: 3, unit_price: 2, invoice: invoice)
    FactoryGirl.create(:transaction, result: 'expired', invoice: invoice)

    invoice = FactoryGirl.create(:invoice, merchant: merchant2)
    FactoryGirl.create(:invoice_item, item: item, quantity: 3, unit_price: 2, invoice: invoice)
    FactoryGirl.create(:transaction, result: 'success', invoice: invoice)
  end

  describe '#index' do
    it 'returns the total revenue across all merchants for a specific date' do
      revenue_setup
      get :index, date: merchant1.items.first.created_at

      expect(json_response['total_revenue']).to eq '0.0'
    end
  end
end
