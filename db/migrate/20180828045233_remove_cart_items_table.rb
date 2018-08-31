class RemoveCartItemsTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :cart_items
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
