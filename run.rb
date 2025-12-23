# frozen_string_literal: true

# Main application orchestrator for the Sales Tax Calculator.
# Loads test data, processes items, and generates formatted receipts
require_relative 'item'
require_relative 'each_item'
require_relative 'receipt'
require_relative 'seeds'

def process_input(input_data, input_number)
  receipt = Receipt.new

  input_data.each do |line_data|
    quantity = line_data[:quantity]
    item = Item.new(**line_data.except(:quantity))
    each_item = EachItem.new(item, quantity)

    receipt.add_each_item(each_item)
  end

  puts "Output #{input_number}:"
  puts receipt
end

puts 'Sales Tax Calculator - Processing All Test Cases'
puts '=' * 50
puts

INPUT_1_DATA = INPUT_1
INPUT_2_DATA = INPUT_2
INPUT_3_DATA = INPUT_3

process_input(INPUT_1_DATA, 1)
process_input(INPUT_2_DATA, 2)
process_input(INPUT_3_DATA, 3)

puts 'All test cases processed successfully!'
