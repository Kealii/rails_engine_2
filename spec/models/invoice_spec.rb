require 'rails_helper'

RSpec.describe Invoice, type: :model do

  let!(:invoice1)     { create(:invoice) }
  let!(:invoice2)     { create(:invoice) }
  let!(:transaction1) { create(:transaction,
                               invoice: invoice1,
                               result: 'success' )}
  let!(:transaction2) { create(:transaction,
                               invoice: invoice2,
                               result: 'failed') }

  describe '#successful' do
    it 'returns all invoices with a successful transaction' do
      successful_invoices = Invoice.successful

      expect(successful_invoices.count).to eq 1
      expect(successful_invoices.first.id).to eq invoice1.id
    end
  end

  describe '#pending' do
    it 'returns all invoices with a failed transaction' do
      pending_invoices = Invoice.pending

      expect(pending_invoices.count).to eq 1
      expect(pending_invoices.first.id).to eq invoice2.id
    end
  end
end
