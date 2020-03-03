class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.string :name
      t.string :description
      t.references :merchant, foreign_key: true
      t.integer :min_quantity

      t.timestamps
    end
  end
end
