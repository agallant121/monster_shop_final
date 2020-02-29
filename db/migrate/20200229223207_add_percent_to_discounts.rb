class AddPercentToDiscounts < ActiveRecord::Migration[5.1]
  def change
    add_column :discounts, :percent, :integer
  end
end
