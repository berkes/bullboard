# frozen_string_literal: true

##
# Dashboard is a view over my portfolio
# A Dashboard is a view: it renders data for humans to read
# It is not part of the domain. But can get Aggregates from the domain
# and render those. As a view, it is intentially kept very dumb. It can only
# display and format variables it recieves. No additional logic like totalling.
class Dashboard
  attr_reader :total_buying_price, :number_of_positions, :total_dividend, :currency

  ##
  # Dasboard is a model that gets initialized by feeding a list of events.
  # That is all.
  # It initializes some initial data. And all further behaviour depends on those
  # events: there is no public behaviour such as "add_stock" or "reduce_amount":
  def initialize(events)
    @events = events
    @number_of_positions = 0
    @total_dividend = 0
    @total_buying_price = 0

    @total_value_at = Hash.new(0)
    @tickers = Hash.new(0)
    @events.each { |event| handle_event(event) }
  end

  def total_value
    @total_value_at.values.last
  end

  private

  ##
  # Handles an incoming event.
  # For now, we keep it simple: no DSLs or fancy metaprogramming, just a switch.
  def handle_event(event)
    case event
    when StocksBought
      handle_stocks_bought(event)
    when PriceObtained
      handle_price_obtained(event)
    when DividendPaid
      handle_dividend_paid(event)
    end
  end

  ##
  # The case/when above calls this method for each "StocksBought" event.
  # When we see that event, we mutate our data.
  def handle_stocks_bought(event)
    # So the first event sets the currency. It is then locked.
    # In future, we'll see that this is not correct business-logic, as we
    # can have stocks in mutliple currencies. For now this suffices.
    @currency ||= event.currency

    # Any event adds the subtotal of that event onto the "total buying price"
    @total_buying_price += event.amount * event.price

    # If we haven't seen this ticker symbol yet, it is a new position,
    # which increases the number of positions with one. And we add the
    # ticker symbol to the list of seen symbols, for future events.
    @number_of_positions += 1 unless @tickers.key?(event.ticker)
    @tickers[event.ticker] += event.amount

    nil
  end

  def handle_price_obtained(event)
    @currency ||= event.currency

    @total_value_at[event.obtained_at] += @tickers[event.ticker] * event.price

    nil
  end

  def handle_dividend_paid(event)
    @currency ||= event.currency
    # Once we get paid dividend, the event contains the amount of dividend paid
    # *per stock*. We then look up how many of that stock we own, so we can
    # calculate the total amount of dividend paid.
    @total_dividend += event.amount * @tickers[event.ticker]

    nil
  end
end
