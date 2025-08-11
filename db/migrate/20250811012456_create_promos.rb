class CreatePromos < ActiveRecord::Migration[7.2]
  def change
    create_table :promos do |t|
      t.string :code
      t.string :product_code
      t.text :total_items, array: true, default: []
      t.string :discount_type
      t.text :description
      t.decimal :discount_value

      t.timestamps
    end
  end
end
