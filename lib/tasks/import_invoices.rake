require 'csv'

namespace :import_invoices do
  task create_invoices: :environment do
    csv_data = File.read('app/assets/data/invoices.csv')
    invoice_data = CSV.parse(csv_data, headers: true)
    invoice_data.each do |row|
      Invoice.create!(row.to_hash)
    end
  end
end