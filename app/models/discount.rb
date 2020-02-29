class Discount < ApplicationRecord
  validates_presence_of :name, :description, :min_quantity, :max_quantity

  belongs_to :merchant
end
