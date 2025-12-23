# frozen_string_literal: true

# Represents each item in a shopping receipt, combining an Item with a quantity.
class EachItem
  attr_reader :item, :quantity, :item_total, :item_tax_total

  def initialize(item, quantity)
    validate_inputs(item, quantity)

    @item = item
    @quantity = quantity

    @item_total = item.total_price * quantity
    @item_tax_total = item.tax_amount * quantity
  end

  def to_s
    "#{quantity} #{item}: #{format('%.2f', item_total)}"
  end

  private

  def validate_inputs(item, quantity)
    raise ArgumentError, 'Item cannot be nil' if item.nil?
    raise ArgumentError, 'Quantity must be positive' if quantity.nil? || quantity <= 0
  end
end
