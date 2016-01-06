class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def revenue
    #TODO unit test me prease :)
    invoices.successful.joins(:invoice_items).sum("quantity * unit_price")
  end

end