# frozen_string_literal: true

##
# Dashboard is a view over my portfolio
# A Dashboard is a view: it renders data for humans to read
# It is not part of the domain. But can get Aggregates from the domain
# and render those. As a view, it is intentially kept very dumb. It can only
# display and format variables it recieves. No additional logic like totalling.
class Dashboard
  attr_reader :total_buying_price, :number_of_positions, :currency

  ##
  # Dasboard is a model that gets initialized by feeding a list of events.
  # That is all.
  # It initializes some initial data. And all further behaviour depends on those
  # events: there is no public behaviour such as "add_stock" or "reduce_amount":
  def initialize(events)
    @events = events
    @total_buying_price = 0
    @number_of_positions = 0

    @tickers = Set.new # A set is basically a unique Array in Ruby

    @events.each { |event| handle_event(event) }
  end

  private

  ##
  # Handles an incoming event.
  # For now, we keep it simple: no DSLs or fancy metaprogramming, just a switch.
  def handle_event(event)
    case event
    when StocksBought
      handle_stocks_bought(event)
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
    # uses Set.add?, which returns nil(falsey) if the item is in the set already.
    @number_of_positions += 1 if @tickers.add?(event.ticker)
  end
end
