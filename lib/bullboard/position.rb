# frozen_string_literal: true

##
# A position is the amount of a security, asset, or property that is owned (or
# sold short) by some individual or other entity.
class Position
  attr_reader :total_buying_price

  def initialize(ticker:, currency:)
    @events = []
    @ticker = ticker
    @currency = currency
    @total_buying_price = 0
  end

  def add_transaction(amount:, price:)
    handle_event(PositionAdded.new(amount: amount, price: price))
  end

  private

  attr_reader :events

  ##
  # Handles an incoming event.
  # For now, we keep it simple: no DSLs or fancy metaprogramming, just a switch.
  def handle_event(event)
    @events << event
    case event
    when PositionAdded
      handle_position_added(event)
    end
  end

  ##
  # Our handle_event calls this method for each PositionAdded event
  def handle_position_added(event)
    @total_buying_price += event.amount * event.price
  end
end

class PositionAdded < OpenStruct
end
