require 'csv'

namespace :import_invoice_items do
  task create_invoice_items: :environment do
    csv_data = File.read('app/assets/data/invoice_items.csv')
    invoice_item_data = CSV.parse(csv_data, headers: true)
    invoice_item_data.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end
end