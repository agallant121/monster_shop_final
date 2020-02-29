require 'rails_helper'

RSpec.describe Discount do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :min_quantity}
    it {should validate_presence_of :max_quantity}
  end

  describe 'Relationships' do
    it {should belong_to :merchant}
  end
end
