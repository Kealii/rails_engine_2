require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '#favorite_merchant' do
    it 'returns a merchant' do
      customer = create(:customer)
    end
  end
end
