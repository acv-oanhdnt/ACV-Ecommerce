class ChangeDeviseUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :address
    add_column :users, :primary_address_id, :integer
  end
end
