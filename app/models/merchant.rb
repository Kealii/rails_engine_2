class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def revenue(params)
    #TODO unit test me prease :)
      if params[:date]
        revenue_by_date(params[:date])
      else
        { revenue: invoices.successful.joins(:invoice_items).sum("quantity * unit_price") }
      end
  end

  def revenue_by_date(date)
    #TODO unit test me toooo
    { revenue: invoices.successful.joins(:invoice_items).where({created_at: date}).sum("quantity * unit_price") }
  end

  def self.revenue_ranking(quantity)
    top_merchants = Merchant.all.map do |merchant|
      [merchant, merchant.invoices.successful.joins(:invoice_items).sum("quantity * unit_price")]
    end
    top_merchants.sort_by { |merchant| merchant.last }.reverse.map(&:first).first(quantity.to_i)
  end

  def self.item_ranking(quantity)
    top_merchants = Merchant.all.map do |merchant|
      [merchant, merchant.invoices.successful.joins(:invoice_items).sum("quantity")]
    end
    top_merchants.sort_by { |merchant| merchant.last }.reverse.map(&:first).first(quantity.to_i)
  end

end