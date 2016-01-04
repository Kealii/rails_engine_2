require 'csv'

namespace :import_merchants do
  task create_merchants: :environment do
    csv_data = File.read('app/assets/data/merchants.csv')
    merchant_data = CSV.parse(csv_data, headers: true)
    merchant_data.each do |row|
      Merchant.create!(row.to_hash)
    end
  end
end