class AddUsedCountToFlowerDetail < ActiveRecord::Migration[6.1]
  def change
    add_column :flower_details, :used_count, :integer, :null => false, :default => 0
  end
end
