require 'rails_helper'

RSpec.describe Api::V1::BestDayController, type: :controller do

  let!(:item1) { create(:item) }
  let!(:item2) { create(:item) }

  def revenue_setup
    create_item(item1, 'success')
    create_item(item1, 'success')
    create_item(item2, 'success')
  end

  def create_item(item, result)
    invoice = create(:invoice)
    create(:invoice_item, item: item,     invoice: invoice)
    create(:transaction,  result: result, invoice: invoice)
  end

  describe 'GET #index' do
    it 'returns the date with the most sales for the item' do
      item2.created_at = item2.created_at - 1.day
      get :index, item_id: item1.id

      expect(response).to have_http_status :success
    end
  end
end
