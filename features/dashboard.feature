Feature: Dashboard

  So that I can see the most important figures at a glance
  As a user
  I want to see important numbers

  Scenario: Total Buy Price
    Given I have the following stock transactions
      | Ticker  | Currency | Amount | Price |
      | AAPL    | USD      | 1      | 60    |
      | AAPL    | USD      | 1      | 80    |
      | ESTC    | USD      | 3      | 20    |
    When I check my dashboard
    Then I should see "Total Buying Price: 200 USD"

  Scenario: Total Positions
    Given I have the following stock transactions
      | Ticker  | Currency | Amount  | Price |
      | AAPL    | USD      | 1       | 60    |
      | AAPL    | USD      | 1       | 90    |
      | TSLA    | USD      | 1       | 80    |
      | ESTC    | USD      | 3       | 20    |
    When I check my dashboard
    Then I should see "Amount of positions: 3"


