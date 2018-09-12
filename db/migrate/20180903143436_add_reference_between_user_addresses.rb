class AddReferenceBetweenUserAddresses < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_addresses, :user, index: true
  end
end
