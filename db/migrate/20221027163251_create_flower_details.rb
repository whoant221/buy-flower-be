class CreateFlowerDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :flower_details do |t|
      t.references :flower, null: false, foreign_key: true
      t.integer :count
      t.timestamp :expiration_at

      t.timestamps
    end
  end
end
