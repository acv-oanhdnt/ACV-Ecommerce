class DeleteFieldFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :primary_address_id
  end
end
