class AddPaymentToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :pay_stt, :boolean, default: false
    add_column :orders, :payment_id, :string
    add_index :orders, :payment_id
  end
end
