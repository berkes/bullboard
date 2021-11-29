# frozen_string_literal: true

Given('I have the following stock transactions') do |transactions|
  # Cucumber internals: our table has only Strings, and we need
  # the price and amount to be integers; otherwise adding and multiplying
  # will do weird things (Yes, in Ruby you can accidentally multiply or add
  # Strings)
  transactions.map_column!('Amount', &:to_i)
  transactions.map_column!('Price', &:to_i)

  @events = []
  transactions.symbolic_hashes.each do |row|
    @events << StocksBought.new(row)
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
