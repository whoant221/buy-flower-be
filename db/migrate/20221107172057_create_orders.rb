class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.decimal :original_price
      t.decimal :sale_price
      t.string :receive_address
      t.string :note
      t.string :state
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
