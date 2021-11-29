# frozen_string_literal: true

##
# Dashboard is a view over my portfolio
# A Dashboard is a view: it renders data for humans to read
# It is not part of the domain. But can get Aggregates from the domain
# and render those. As a view, it is intentially kept very dumb. It can only
# display and format variables it recieves. No additional logic like totalling.
class DashboardView < SimpleDelegator
  def to_s
    "Total Buying Price: #{total_buying_price} #{currency}"
  end
end
