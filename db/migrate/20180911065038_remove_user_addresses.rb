class RemoveUserAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address, :string
    drop_table :user_addresses
  end
end
