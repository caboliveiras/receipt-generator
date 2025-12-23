# frozen_string_literal: true

require_relative '../item'
require_relative '../each_item'

RSpec.describe EachItem do
  let(:item) { Item.new(name: 'book', price: 12.49, category: :book) }
  let(:each_item) { EachItem.new(item, 2) }

  describe '#initialize' do
    it 'stores item and quantity' do
      expect(each_item.item).to eq(item)
      expect(each_item.quantity).to eq(2)
    end

    it 'calculates item_total correctly' do
      expect(each_item.item_total).to eq(24.98)
    end

    it 'calculates item_tax_total correctly' do
      expect(each_item.item_tax_total).to eq(0.0)
    end
  end

  describe 'with taxable items' do
    let(:taxable_item) { Item.new(name: 'music CD', price: 14.99, category: :general) }
    let(:taxable_each_item) { EachItem.new(taxable_item, 1) }

    it 'calculates totals with tax' do
      expect(taxable_each_item.item_total.round(2)).to eq(16.49)
      expect(taxable_each_item.item_tax_total.round(2)).to eq(1.50)
    end
  end

  describe 'with multiple quantities' do
    let(:imported_item) { Item.new(name: 'boxes of chocolates', price: 11.25, category: :food, imported: true) }
    let(:multiple_each_item) { EachItem.new(imported_item, 3) }

    it 'multiplies totals by quantity' do
      expect(multiple_each_item.item_total.round(2)).to eq(35.55)
      expect(multiple_each_item.item_tax_total.round(2)).to eq(1.80)
    end
  end

  describe '#to_s' do
    it 'formats line item correctly' do
      expect(each_item.to_s).to eq('2 book: 24.98')
    end

    it 'formats imported items correctly' do
      imported_item = Item.new(name: 'bottle of perfume', price: 47.50, category: :general, imported: true)
      imported_each_item = EachItem.new(imported_item, 1)

      expect(imported_each_item.to_s).to eq('1 imported bottle of perfume: 54.65')
    end
  end

  describe 'input validation' do
    it 'accepts valid inputs without errors' do
      valid_item = Item.new(name: 'book', price: 12.49, category: :book)
      expect { EachItem.new(valid_item, 1) }.not_to raise_error
      expect { EachItem.new(valid_item, 5) }.not_to raise_error
    end
  end
end
