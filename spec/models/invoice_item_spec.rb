require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe '#convert_unit_price' do
    it 'divides the unit price by 100 before saving' do
      unit_price = 100
      invoice_item = create(:invoice_item, unit_price: unit_price)

      expect(invoice_item.unit_price).to eq (unit_price / 100)
    end
  end
end
