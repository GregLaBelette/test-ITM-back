# frozen_string_literal:true

# Order model create migration
class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.date :date
      t.string :country
      t.string :product_code
      t.string :product_description
      t.integer :quantity
      t.decimal :unit_price

      t.timestamps
    end
  end
end
