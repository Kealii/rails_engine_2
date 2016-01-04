require 'csv'

namespace :import_customers do
  task create_customers: :environment do
    csv_data = File.read('app/assets/data/customers.csv')
    customer_data = CSV.parse(csv_data, headers: true)
    customer_data.each do |row|
      Customer.create!(row.to_hash)
    end
  end
end