# frozen_string_literal: true

# Represents each item in a shopping receipt, combining an Item with a quantity.
class EachItem
  attr_reader :item, :quantity, :item_total, :item_tax_total

  def initialize(item, quantity)
    @item = item
    @quantity = quantity

    @item_total = item.total_price * quantity
    @item_tax_total = item.tax_amount * quantity
  end

  def to_s
    "#{quantity} #{item}: #{format('%.2f', item_total)}"
  end
end
