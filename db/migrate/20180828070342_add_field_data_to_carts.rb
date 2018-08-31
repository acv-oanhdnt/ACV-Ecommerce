class AddFieldDataToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :data, :json, default: {}
  end
end
