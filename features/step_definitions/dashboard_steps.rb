# frozen_string_literal: true

require 'date'
require 'bigdecimal'

Before do
  @events = []
end

Given('I have the following stock transactions') do |transactions|
  # Cucumber internals: our table has only Strings, and we need
  # the price and amount to be integers; otherwise adding and multiplying
  # will do weird things (Yes, in Ruby you can accidentally multiply or add
  # Strings)
  transactions.map_column!('Amount', &:to_i)
  transactions.map_column!('Price', &:to_i)

  transactions.symbolic_hashes.each do |row|
    @events << StocksBought.new(row)
  end
end

Given('{string} pays {string} dividend per share on {string}') do |ticker, amount, _date|
  (amount_dec, currency) = amount.split(' ')
  amount_cents = (BigDecimal(amount_dec) * 100).to_i

  @events << DividendPaid.new(ticker: ticker, amount: amount_cents, currency: currency)
end

Given('the prices change to the following values on {string}') do |date, prices|
  prices.map_column!('Price', &:to_i)

  prices.symbolic_hashes.each do |row|
    @events << PriceObtained.new(row.merge(obtained_at: DateTime.parse(date)))
  end
end

When('I check my dashboard') do
  dashboard = Dashboard.new(@events)
  # This has nothing to do with EventSourcing. But we want to keep
  # logic separated from display so we can follow along easier.
  @output = DashboardView.new(dashboard)
end

Then('I should see {string}') do |price|
  assert_includes(@output.to_s, price)
end
