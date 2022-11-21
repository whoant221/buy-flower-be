class CreateFlowerBuds < ActiveRecord::Migration[6.1]
  def change
    create_table :flower_buds do |t|
      t.references :flower, null: false, foreign_key: true
      t.references :bud, null: false, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
