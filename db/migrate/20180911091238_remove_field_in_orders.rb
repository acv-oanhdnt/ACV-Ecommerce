class RemoveFieldInOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :address_name
  end
end
