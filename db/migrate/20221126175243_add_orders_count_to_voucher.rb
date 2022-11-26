class AddOrdersCountToVoucher < ActiveRecord::Migration[6.1]
  def change
    add_column :vouchers, :orders_count, :integer
  end
end
