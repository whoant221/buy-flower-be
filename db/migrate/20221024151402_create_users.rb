class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.string :phone_number, null: false
      t.string :address, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true

  end
end
