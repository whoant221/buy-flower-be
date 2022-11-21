class CreateBuds < ActiveRecord::Migration[6.1]
  def change
    create_table :buds do |t|
      t.string :name

      t.timestamps
    end
  end
end
