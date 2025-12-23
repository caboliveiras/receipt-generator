# frozen_string_literal: true

INPUT_1 = [
  { quantity: 2, name: 'book', price: 12.49, category: :book, imported: false },
  { quantity: 1, name: 'music CD', price: 14.99, category: :general, imported: false },
  { quantity: 1, name: 'chocolate bar', price: 0.85, category: :food, imported: false }
].freeze

INPUT_2 = [
  { quantity: 1, name: 'box of chocolates', price: 10.00, category: :food, imported: true },
  { quantity: 1, name: 'bottle of perfume', price: 47.50, category: :general, imported: true }
].freeze

INPUT_3 = [
  { quantity: 1, name: 'bottle of perfume', price: 27.99, category: :general, imported: true },
  { quantity: 1, name: 'bottle of perfume', price: 18.99, category: :general, imported: false },
  { quantity: 1, name: 'packet of headache pills', price: 9.75, category: :medical, imported: false },
  { quantity: 3, name: 'boxes of chocolates', price: 11.25, category: :food, imported: true }
].freeze

# If you want to load all inputs together
ALL_INPUTS = [INPUT_1, INPUT_2, INPUT_3].freeze
