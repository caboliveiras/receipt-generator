# frozen_string_literal: true

require_relative '../run'

RSpec.describe 'run.rb' do
  describe '#process_input' do
    it 'processes INPUT_1 correctly' do
      expected_output = [
        'Output 1:',
        '2 book: 24.98',
        '1 music CD: 16.49',
        '1 chocolate bar: 0.85',
        'Sales Taxes: 1.50',
        'Total: 42.32'
      ].join("\n") + "\n"

      expect { process_input(INPUT_1, 1) }.to output(expected_output).to_stdout
    end

    it 'processes INPUT_2 correctly' do
      expected_output = [
        'Output 2:',
        '1 imported box of chocolates: 10.50',
        '1 imported bottle of perfume: 54.65',
        'Sales Taxes: 7.65',
        'Total: 65.15'
      ].join("\n") + "\n"

      expect { process_input(INPUT_2, 2) }.to output(expected_output).to_stdout
    end

    it 'processes INPUT_3 correctly' do
      expected_output = [
        'Output 3:',
        '1 imported bottle of perfume: 32.19',
        '1 bottle of perfume: 20.89',
        '1 packet of headache pills: 9.75',
        '3 imported boxes of chocolates: 35.55',
        'Sales Taxes: 7.90',
        'Total: 98.38'
      ].join("\n") + "\n"

      expect { process_input(INPUT_3, 3) }.to output(expected_output).to_stdout
    end
  end
end
