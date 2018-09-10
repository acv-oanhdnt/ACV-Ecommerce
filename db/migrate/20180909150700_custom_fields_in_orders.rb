class CustomFieldsInOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :email, :string
    remove_column :orders, :line2
    remove_column :orders, :city
    remove_column :orders, :country_code
    remove_column :user_addresses, :line2
    remove_column :user_addresses, :city
    remove_column :user_addresses, :country_code
  end
end
