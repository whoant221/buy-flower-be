# frozen_string_literal: true
module ReportService
  class Product
    class << self

      def get_analyze_users
        User.count
      end

      def get_analyze_orders
        Order.count
      end

      def get_analyze_flowers
        Flower.count
      end

    end
  end
end

