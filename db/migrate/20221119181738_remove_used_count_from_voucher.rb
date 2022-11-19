class RemoveUsedCountFromVoucher < ActiveRecord::Migration[6.1]
  def change
    remove_column :vouchers, :used_count, :integer
  end
end
