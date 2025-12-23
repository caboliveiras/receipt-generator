# frozen_string_literal: true

require_relative '../item'
require_relative '../each_item'
require_relative '../receipt'

RSpec.describe Receipt do
  let(:receipt) { Receipt.new }

  describe '#initialize' do
    it 'starts with empty each_items array' do
      expect(receipt.each_items).to be_empty
    end
  end

  describe '#add_each_item' do
    let(:item) { Item.new(name: 'book', price: 12.49, category: :book) }
    let(:each_item) { EachItem.new(item, 2) }

    it 'adds each_item to collection' do
      receipt.add_each_item(each_item)
      expect(receipt.each_items).to include(each_item)
      expect(receipt.each_items.length).to eq(1)
    end
  end

  describe '#total_sales_tax' do
    context 'with no items' do
      it 'returns zero' do
        expect(receipt.total_sales_tax).to eq(0.0)
      end
    end

    context 'with mixed items' do
      let(:book_item) { Item.new(name: 'book', price: 12.49, category: :book) }
      let(:cd_item) { Item.new(name: 'music CD', price: 14.99, category: :general) }
      let(:chocolate_item) { Item.new(name: 'chocolate bar', price: 0.85, category: :food) }

      before do
        receipt.add_each_item(EachItem.new(book_item, 2))
        receipt.add_each_item(EachItem.new(cd_item, 1))
        receipt.add_each_item(EachItem.new(chocolate_item, 1))
      end

      it 'calculates total tax correctly' do
        expect(receipt.total_sales_tax).to eq(1.50)
      end
    end
  end

  describe '#grand_total' do
    context 'with mixed items' do
      let(:book_item) { Item.new(name: 'book', price: 12.49, category: :book) }
      let(:cd_item) { Item.new(name: 'music CD', price: 14.99, category: :general) }
      let(:chocolate_item) { Item.new(name: 'chocolate bar', price: 0.85, category: :food) }

      before do
        receipt.add_each_item(EachItem.new(book_item, 2))
        receipt.add_each_item(EachItem.new(cd_item, 1))
        receipt.add_each_item(EachItem.new(chocolate_item, 1))
      end

      it 'calculates grand total correctly' do
        expect(receipt.grand_total).to eq(42.32)
      end
    end
  end

  describe '#to_s' do
    context 'with empty receipt' do
      it 'returns appropriate message' do
        expect(receipt.to_s).to eq('No items in receipt')
      end
    end

    context 'with items' do
      let(:book_item) { Item.new(name: 'book', price: 12.49, category: :book) }
      let(:cd_item) { Item.new(name: 'music CD', price: 14.99, category: :general) }

      before do
        receipt.add_each_item(EachItem.new(book_item, 2))
        receipt.add_each_item(EachItem.new(cd_item, 1))
      end

      it 'formats complete receipt correctly' do
        expected_output = [
          '2 book: 24.98',
          '1 music CD: 16.49',
          'Sales Taxes: 1.50',
          'Total: 41.47'
        ].join("\n")

        expect(receipt.to_s).to eq(expected_output)
      end
    end
  end
end
