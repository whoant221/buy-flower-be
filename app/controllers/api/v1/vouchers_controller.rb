module Api
  module V1
    class VouchersController < ApiController
      before_action :required_login

      def index
        vouchers = voucher_service.valid_vouchers(voucher_params[:price])
        render 'index', locals: {
          vouchers: vouchers
        }, formats: [:json], status: :ok
      end

      def valid_price
        sale_price = voucher_service.sale_price(voucher_params[:price].to_i)
        render 'valid_price', locals: {
          sale_price: sale_price
        }, formats: [:json], status: :ok
      end

      private

      def voucher_service
        @voucher_service ||= VoucherService::Client.new(code: voucher_params[:code], user: current_user)
      end

      def voucher_params
        params.permit(:code, :price)
      end

    end
  end
end

