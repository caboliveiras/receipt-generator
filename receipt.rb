# frozen_string_literal: true

# Represents a shopping receipt that manages a collection of EachItem objects.
class Receipt
  attr_reader :each_items

  def initialize
    @each_items = []
  end

  def add_each_item(each_item)
    @each_items << each_item
  end

  def total_sales_tax
    each_items.sum(&:item_tax_total)
  end

  def grand_total
    each_items.sum(&:item_total)
  end

  def to_s
    return 'No items in receipt' if each_items.empty?

    receipt_lines = each_items.map(&:to_s)
    receipt_lines << "Sales Taxes: #{format('%.2f', total_sales_tax)}"
    receipt_lines << "Total: #{format('%.2f', grand_total)}"

    receipt_lines.join("\n")
  end
end
