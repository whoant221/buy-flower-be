class AddShippingRefToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :shipping_ref, :string
  end
end
