class AddCountToBud < ActiveRecord::Migration[6.1]
  def change
    add_column :buds, :count, :int
  end
end
