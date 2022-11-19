class CreateVoucherOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :voucher_orders do |t|
      t.references :voucher, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
