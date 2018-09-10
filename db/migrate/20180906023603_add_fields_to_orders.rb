class AddFieldsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :address_name, :string
    add_column :orders, :line2, :string
    add_column :orders, :city, :string
    add_column :orders, :country_code, :string
  end
end
