require 'csv'

namespace :import_items do
  task create_items: :environment do
    csv_data = File.read('app/assets/data/items.csv')
    item_data = CSV.parse(csv_data, headers: true)
    item_data.each do |row|
      Item.create!(row.to_hash)
    end
  end
end