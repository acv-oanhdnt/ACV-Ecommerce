class AddFieldsToUserAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :user_addresses, :line2, :string
    add_column :user_addresses, :city, :string
    add_column :user_addresses, :country_code, :string, limit: 2
  end
end
