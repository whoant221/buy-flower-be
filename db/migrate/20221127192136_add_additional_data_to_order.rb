class AddAdditionalDataToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :additional_data, :jsonb
  end
end
