require 'csv'

namespace :import_transactions do
  task create_transactions: :environment do
    csv_data = File.read('app/assets/data/transactions.csv')
    transaction_data = CSV.parse(csv_data, headers: true)
    transaction_data.each do |row|
      Transaction.create!(row.to_hash)
    end
  end
end