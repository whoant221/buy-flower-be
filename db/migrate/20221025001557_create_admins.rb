class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :password_digest
      t.string :name

      t.timestamps
    end
    add_index :admins, :username, unique: true
  end
end
