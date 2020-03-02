class RemoveItemsFromDiscounts < ActiveRecord::Migration[5.1]
  def change
    remove_reference :discounts, :item, foreign_key: true
  end
end
