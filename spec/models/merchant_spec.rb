require 'rails_helper'

RSpec.describe Merchant, type: :model do

  let!(:merchant)  { create(:merchant) }
  let!(:customer1) { create(:customer) }
  let!(:customer2) { create(:customer) }

  def customer_setup
    create_transactions(customer1, 'success')
    create_transactions(customer2, 'expired')
  end

  def create_transactions(customer, result)
    item    = create(:item,    merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create(:invoice_item, item: item,     invoice: invoice)
    create(:transaction,  result: result, invoice: invoice)
  end

  describe '#favorite_customer' do
    it 'returns a customer' do
      customer_setup
      favorite_customer = merchant.favorite_customer

      expect(favorite_customer).to be_kind_of Customer
    end
  end

  describe '#revenue' do
    it 'returns revenue for a merchant' do
      customer_setup
      revenue = merchant.revenue

      expect(revenue.keys.first).to eq :revenue
    end
  end

  describe '#revenue by date' do
    it 'returns revenue for a merchant for a specific date' do
      customer_setup
      revenue = merchant.revenue(Transaction.first.created_at)

      expect(revenue.keys.first).to eq :revenue
    end
  end

  describe '#total revenue by date' do
    it 'returns total revenue for all merchants' do
      customer_setup
      total_revenue = Merchant.total_revenue_by_date(merchant.created_at)

      expect(total_revenue.keys.first).to eq :total_revenue
    end
  end

  describe '#revenue ranking' do
    it 'returns a collection of merchants' do
      customer_setup
      ranked_merchants = Merchant.revenue_ranking(1)

      expect(ranked_merchants.class).to eq Array
      expect(ranked_merchants.count).to eq 1
      expect(ranked_merchants.first).to be_kind_of Merchant
    end
  end

  describe '#item ranking' do
    it 'returns a collection of merchants' do
      customer_setup
      ranked_merchants = Merchant.item_ranking(1)

      expect(ranked_merchants.class).to eq Array
      expect(ranked_merchants.count).to eq 1
      expect(ranked_merchants.first).to be_kind_of Merchant
    end
  end

end
