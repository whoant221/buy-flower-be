module Api
  module Admin
    class ReportsController < ApiController
      def analyze_access_page
        data = ReportService::Access.get_analyze_in_month(params[:from_date], params[:to_date])
        render 'analyze_access_page', locals: {
          data: data
        }, formats: [:json], status: :ok
      end

      def analyze_profit
        data = ReportService::Profit.get_analyze_by_month
        render 'analyze_access_page', locals: {
          data: data
        }, formats: [:json], status: :ok
      end

      def analyze_product
        data = {
          total_users: ReportService::Product.get_analyze_users,
          total_flowers: ReportService::Product.get_analyze_flowers,
          total_orders: ReportService::Product.get_analyze_orders,
          total_flower_sold_out_flowers: 100
        }

        render 'analyze_product', locals: {
          data: data
        }, formats: [:json], status: :ok
      end

    end
  end
end
