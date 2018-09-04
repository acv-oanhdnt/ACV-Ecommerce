class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone_number
      t.string :shipping_address
      t.decimal :total_amount, precision: 10, scale: 2
      t.string :note
      t.json :data, default: '{}'

      t.timestamps
    end
  end
end
