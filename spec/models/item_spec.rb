require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#convert_unit_price' do
    it 'divides the unit price by 100 before saving' do
      unit_price = 100
      item = create(:item, unit_price: unit_price)

      expect(item.unit_price).to eq (unit_price / 100)
    end
  end

  describe '#revenue_ranking' do
    it 'returns a collection of items' do
      3.times { create(:item) }
      quantity = 2
      items = Item.revenue_ranking(quantity)

      expect(items.count).to eq quantity
      expect(items.first).to be_kind_of Item
    end
  end

  describe '#item_ranking' do
    it 'returns a collection of items' do
      3.times { create(:item) }
      quantity = 2
      items = Item.item_ranking(quantity)

      expect(items.count).to eq quantity
      expect(items.first).to be_kind_of Item
    end
  end

  describe '#best_day' do
    it 'returns a date for a specific item' do
      item = create(:item)
      best_day = item.best_day

      expect(best_day).to be_kind_of Hash
    end
  end
end
