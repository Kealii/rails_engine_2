class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def favorite_customer
    successful_invoices = invoices.successful.group_by(&:customer_id)
    sorted_invoices     = successful_invoices.sort_by { |_, v| v.count }.reverse.flatten
    top_customer        = sorted_invoices.first
    Customer.find(top_customer)
  end

  def pending_customers
    invoices.pending.joins(:customer).uniq
  end

  def revenue(date = nil)
    if date
      { revenue: successful_invoices.where({created_at: date}).sum("quantity * unit_price") }
    else
      { revenue: successful_invoices.sum("quantity * unit_price") }
    end
  end

  def successful_invoices
    invoices.successful.joins(:invoice_items)
  end

  def self.total_revenue_by_date(date)
    { total_revenue: Invoice.successful.joins(:invoice_items).where({created_at: date}).sum("quantity * unit_price") }
  end

  def self.revenue_ranking(quantity)
    ranking(quantity, "quantity * unit_price")
  end

  def self.item_ranking(quantity)
    ranking(quantity, "quantity")
  end

  def self.ranking(quantity, rank_by)
    top_merchants = Merchant.all.map do |merchant|
      [merchant, merchant.successful_invoices.sum(rank_by)]
    end
    top_merchants.sort_by(&:last).reverse.map(&:first).first(quantity.to_i)
  end
end