module Api
  module V1
    class VouchersController < ApiController
      def index
        vouchers = Voucher.valid(voucher_params[:price])
        render 'index', locals: {
          vouchers: vouchers
        }, formats: [:json], status: :ok
      end

      def valid_price
        sale_price = VoucherService::Client.new(code: voucher_params[:code]).sale_price(voucher_params[:price].to_i)
        render 'valid_price', locals: {
          sale_price: sale_price
        }, formats: [:json], status: :ok
      end

      private

      def voucher_params
        params.permit(:code, :price)
      end

    end
  end
end

