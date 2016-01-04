class CreateItems < ActiveRecord::Migration
  def change
    enable_extension 'citext'
    create_table :items do |t|
      t.citext  :name
      t.citext  :description
      t.decimal :unit_price
      t.integer :merchant_id

      t.timestamps null: false
    end
  end
end
