class CreateCategoryFlowers < ActiveRecord::Migration[6.1]
  def change
    create_table :category_flowers do |t|
      t.references :category, null: false, foreign_key: true
      t.references :flower, null: false, foreign_key: true

      t.timestamps
    end
  end
end
