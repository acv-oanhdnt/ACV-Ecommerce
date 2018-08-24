class AddReferencesToCart < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_items, :cart, index: true
    add_reference :cart_items, :product, index: true
  end
end
