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

  def revenue(params)
    if params[:date]
      revenue_by_date(params[:date])
    else
      { revenue: invoices.successful.joins(:invoice_items).sum("quantity * unit_price") }
    end
  end

  def revenue_by_date(date)
    { revenue: invoices.successful.joins(:invoice_items).where({created_at: date}).sum("quantity * unit_price") }
  end

  def self.total_revenue_by_date(date)
    { total_revenue: Invoice.successful.joins(:invoice_items).where({created_at: date}).sum("quantity * unit_price") }
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