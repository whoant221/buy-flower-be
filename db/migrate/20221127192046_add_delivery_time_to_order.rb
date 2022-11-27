class AddDeliveryTimeToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivery_time, :timestamp
  end
end
