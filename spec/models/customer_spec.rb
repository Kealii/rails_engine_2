require 'rails_helper'

RSpec.describe Customer, type: :model do

  let!(:customer)  { create(:customer) }
  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }

  def merchant_setup
    create_transactions(merchant1, 'success')
  end

  def create_transactions(merchant, result)
    item    = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create(:invoice_item, item: item, invoice: invoice)
    create(:transaction, result: result, invoice: invoice)
  end

  describe '#favorite_merchant' do
    it 'returns a merchant' do
      merchant_setup
      favorite_merchant = customer.favorite_merchant

      expect(favorite_merchant).to be_kind_of Merchant
    end
  end
end
