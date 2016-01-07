class Item < ActiveRecord::Base
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  before_save :convert_unit_price

  def convert_unit_price
    self.unit_price = self.unit_price / 100
  end

  def self.revenue_ranking(quantity)
    top_items = Item.all.map do |item|
      [item, item.invoices.successful.sum("quantity * unit_price")]
    end
    top_items.sort_by(&:last).reverse.map(&:first).first(quantity.to_i)
  end

  def self.item_ranking(quantity)
    top_items = Item.all.map do |item|
      [item, item.invoices.successful.sum("quantity")]
    end
    top_items.sort_by(&:last).reverse.map(&:first).first(quantity.to_i)
  end

  def best_day
    invoice_days     = invoices.successful.group('"invoices"."created_at"')
    invoice_revenues = invoice_days.sum("quantity")
    best_day = invoice_revenues.sort_by(&:last).reverse.map(&:first).first
    { best_day: best_day }
  end

end
