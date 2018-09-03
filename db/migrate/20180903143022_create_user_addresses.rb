class CreateUserAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_addresses do |t|
      t.string :address
      t.string :name 

      t.timestamps
    end
  end
end
