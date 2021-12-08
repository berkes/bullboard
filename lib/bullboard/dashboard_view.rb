# frozen_string_literal: true

##
# Dashboard is a view over my portfolio
# A Dashboard is a view: it renders data for humans to read
# It is not part of the domain. But can get Aggregates from the domain
# and render those. As a view, it is intentially kept very dumb. It can only
# display and format variables it recieves. No additional logic like totalling.
class DashboardView < SimpleDelegator
  def total_dividend
    format('%.2f', (BigDecimal(super) / 100))
  end

  def to_s
    "Total Buying Price: #{total_buying_price} #{currency}"\
    "Amount of positions: #{number_of_positions}"\
    "Total dividend: #{total_dividend} #{currency}"
  end
end
