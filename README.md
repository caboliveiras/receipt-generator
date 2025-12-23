# Receipt Generator

A Ruby application that calculates receipt details for shopping baskets. Applies basic sales tax and import duty as per the provided rules and generates the total cost of items, along with the amount of sales taxes paid.

## Requirements

- Ruby
- RSpec (for testing)

## Project Structure

The application consists of:

- `Item` - Represents individual items with tax calculation
- `EachItem` - Represents line items (product + quantity)
- `Receipt` - Manages collections of line items and calculates totals
- `seeds.rb` - Input data

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/caboliveiras/receipt-generator.git
   ```

2. Navigate to the project directory:
   ```bash
   cd receipt-generator
   ```

3. Run the application:
   ```bash
   ruby run.rb
   ```

## Notes

Test data is defined in `seeds.rb`

## Tax Rules

- **Basic Sales Tax**: 10% on all goods except books, food, and medical products
- **Import Tax**: Additional 5% on all imported goods (no exemptions)
- **Rounding**: All taxes rounded UP to the nearest $0.05

## Categories

- `:book` - Books (exempt from basic sales tax)
- `:food` - Food items (exempt from basic sales tax)
- `:medical` - Medical products (exempt from basic sales tax)
- `:general` - Other items (subject to basic sales tax)

## Examples

### Input 1:
```
2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

### Output 1:
```
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
```

### Input 2:
```
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50
```

### Output 2:
```
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15
```

### Input 3:
```
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

### Output 3:
```
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```

## Running Tests

Install RSpec:
```bash
gem install rspec
```

Run tests:
```bash
rspec
```
