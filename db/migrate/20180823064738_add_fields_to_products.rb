class AddFieldsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :name, :string
    add_column :products, :description, :text
    add_column :products, :price, :decimal, precision: 10, scale: 2
    add_column :products, :img_url, :string
  end
end
