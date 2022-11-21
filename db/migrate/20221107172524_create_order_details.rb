class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.references :order, null: false, foreign_key: true
      t.references :flower, null: false, foreign_key: true
      t.integer :amount
      t.decimal :price

      t.timestamps
    end
  end
end
