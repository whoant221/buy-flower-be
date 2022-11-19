class CreateVouchers < ActiveRecord::Migration[6.1]
  def change
    create_table :vouchers do |t|
      t.text :title
      t.text :content
      t.integer :limit_count
      t.string :code
      t.datetime :effective_at
      t.datetime :expiration_at
      t.integer :used_count
      t.decimal :discount
      t.decimal :threshold
      t.decimal :max_amount

      t.timestamps
    end
    add_index :vouchers, :code
  end
end
