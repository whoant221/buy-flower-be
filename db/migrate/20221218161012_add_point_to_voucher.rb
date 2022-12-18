class AddPointToVoucher < ActiveRecord::Migration[6.1]
  def change
    add_column :vouchers, :point, :integer
  end
end
