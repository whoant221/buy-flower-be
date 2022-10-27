class RemoveCountFromFlower < ActiveRecord::Migration[6.1]
  def change
    remove_column :flowers, :count, :integer
  end
end
