class RemoveCategoryFromFlowers < ActiveRecord::Migration[6.1]
  def change
    remove_reference :flowers, :category, null: false, foreign_key: true
  end
end
