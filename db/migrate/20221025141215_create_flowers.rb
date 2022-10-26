class CreateFlowers < ActiveRecord::Migration[6.1]
  def change
    create_table :flowers do |t|
      t.string :name
      t.string :color
      t.decimal :original_price
      t.decimal :sale_price
      t.text :description
      t.text :images, array: true, default: []
      t.integer :count
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
