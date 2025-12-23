# frozen_string_literal: true

# Represents a single product with its properties and tax calculations.
class Item
  BASIC_TAX_RATE = 0.10
  IMPORT_TAX_RATE = 0.05
  EXEMPT_CATEGORIES = %i[book food medical].freeze

  attr_reader :name, :price, :category, :imported, :tax_amount, :total_price

  def initialize(name:, price:, category:, imported: false)
    @name = name
    @price = price
    @category = category
    @imported = imported

    @tax_amount = calculate_tax
    @total_price = price + @tax_amount
  end

  def to_s
    parts = []
    parts << 'imported' if imported
    parts << name
    parts.join(' ')
  end

  def tax_exempt?
    EXEMPT_CATEGORIES.include?(category)
  end

  private

  def calculate_tax
    basic_tax = tax_exempt? ? 0.0 : (price * BASIC_TAX_RATE)
    import_tax = imported ? (price * IMPORT_TAX_RATE) : 0.0

    round_up(basic_tax + import_tax)
  end

  def round_up(amount)
    return 0.0 if amount.zero?

    (amount * 20).ceil / 20.0
  end
end
