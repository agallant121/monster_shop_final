class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

  def items
    @contents.map do |item_id, _|
      Item.find(item_id)
    end
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      grand_total += Item.find(item_id).price * quantity
    end
    grand_total
  end

  # def grand_total
  #   if discounted_total == grand_total
  #     grand_total = 0.0
  #     @contents.each do |item_id, quantity|
  #       grand_total += Item.find(item_id).price * quantity
  #     end
  #     grand_total
  #   else
  #     discounted_total
  #   end
  # end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_of(item_id)
    @contents[item_id.to_s] * Item.find(item_id).price
  end

  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end

  def discounted_total
    self.contents.sum do |item_id,quantity|
      item = Item.find(item_id)
      discount_info = Discount.where(merchant_id: item.merchant_id).where("min_quantity <= #{quantity}").order("percent DESC").limit(1)
      if discount_info.length > 0
        ((item.price * (1 - (discount_info[0].percent.to_f/100))) * quantity).round(2)
      else
        item.price * quantity
      end
    end
  end
end
