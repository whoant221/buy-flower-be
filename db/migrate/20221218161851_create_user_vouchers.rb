class CreateUserVouchers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_vouchers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :voucher, null: false, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
