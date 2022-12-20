# frozen_string_literal: true
module ReportService
  class Profit
    class << self
      def get_analyze_by_month
        Order.where(state: Order::SUCCESSFUL)
             .group("date_trunc('month', created_at)")
             .select("date_trunc('month', created_at) as month, sum(sale_price) as sum")
             .order("month ASC")
             .map { |o|  [o.month.strftime("%m/%Y"), o.sum]}

      end
    end
  end
end
