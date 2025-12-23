# frozen_string_literal: true

require_relative '../item'

RSpec.describe Item do
  describe '#initialize' do
    context 'with basic item attributes' do
      let(:item) { Item.new(name: 'book', price: 12.49, category: :book) }

      it 'sets the attributes correctly' do
        expect(item.name).to eq('book')
        expect(item.price).to eq(12.49)
        expect(item.category).to eq(:book)
        expect(item.imported).to be false
      end
    end

    context 'with imported item' do
      let(:item) { Item.new(name: 'perfume', price: 27.99, category: :general, imported: true) }

      it 'sets imported attribute correctly' do
        expect(item.imported).to be true
      end
    end
  end

  describe '#tax_exempt?' do
    context 'when item belongs to exempt category' do
      it 'returns true for books' do
        item = Item.new(name: 'novel', price: 15.99, category: :book)
        expect(item.tax_exempt?).to be true
      end

      it 'returns true for food' do
        item = Item.new(name: 'chocolate', price: 5.99, category: :food)
        expect(item.tax_exempt?).to be true
      end

      it 'returns true for medical' do
        item = Item.new(name: 'aspirin', price: 8.99, category: :medical)
        expect(item.tax_exempt?).to be true
      end
    end

    context 'when item belongs to non-exempt category' do
      it 'returns false for general items' do
        item = Item.new(name: 'music CD', price: 14.99, category: :general)
        expect(item.tax_exempt?).to be false
      end
    end
  end

  describe '#tax_amount' do
    context 'with exempt items' do
      it 'calculates zero tax for domestic books' do
        item = Item.new(name: 'book', price: 12.49, category: :book)
        expect(item.tax_amount).to eq(0.0)
      end

      it 'calculates only import tax for imported books' do
        item = Item.new(name: 'imported book', price: 12.49, category: :book, imported: true)
        expect(item.tax_amount).to eq(0.65) # 12.49 * 0.05 = 0.6245, rounded up to 0.65
      end
    end

    context 'with non-exempt items' do
      it 'calculates basic tax for domestic items' do
        item = Item.new(name: 'music CD', price: 14.99, category: :general)
        expect(item.tax_amount).to eq(1.50)
      end

      it 'calculates basic + import tax for imported items' do
        item = Item.new(name: 'imported perfume', price: 47.50, category: :general, imported: true)
        expect(item.tax_amount).to eq(7.15)
      end
    end

    context 'rounding behavior' do
      it 'rounds up to nearest 0.05' do
        item = Item.new(name: 'test item', price: 18.99, category: :general)
        expect(item.tax_amount).to eq(1.90)
      end

      it 'handles exact 0.05 multiples' do
        item = Item.new(name: 'test item', price: 10.00, category: :general)
        expect(item.tax_amount).to eq(1.00)
      end
    end
  end

  describe '#total_price' do
    it 'calculates correct total for exempt items' do
      item = Item.new(name: 'chocolate bar', price: 0.85, category: :food)
      expect(item.total_price).to eq(0.85)
    end

    it 'calculates correct total for taxable items' do
      item = Item.new(name: 'music CD', price: 14.99, category: :general)
      expect(item.total_price.round(2)).to eq(16.49)
    end
  end

  describe '#to_s' do
    it 'formats domestic items correctly' do
      item = Item.new(name: 'book', price: 12.49, category: :book)
      expect(item.to_s).to eq('book')
    end

    it 'formats imported items correctly' do
      item = Item.new(name: 'bottle of perfume', price: 27.99, category: :general, imported: true)
      expect(item.to_s).to eq('imported bottle of perfume')
    end
  end

  describe 'input validation' do
    it 'accepts valid inputs without errors' do
      expect { Item.new(name: 'book', price: 12.49, category: :book) }.not_to raise_error
      expect { Item.new(name: 'chocolate', price: 5.00, category: :food) }.not_to raise_error
      expect { Item.new(name: 'aspirin', price: 9.75, category: :medical) }.not_to raise_error
      expect { Item.new(name: 'music CD', price: 14.99, category: :general) }.not_to raise_error
    end
  end
end
