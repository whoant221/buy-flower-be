module Api
  module Admin
    class VouchersController < ApiController
      def create
        Voucher.create!(voucher_params)
      end

      def show

      end

      def update

      end

      def index
        vouchers = filter_voucher(params[:state])
        render 'api/admin/vouchers/index', locals: {
          vouchers: vouchers
        }, formats: [:json], status: :ok
      end

      private

      def voucher_params
        params.permit(:code, :content, :discount, :effective_at, :expiration_at, :limit_count, :max_amount, :threshold, :title)
      end

      def filter_voucher(filter)
        return Voucher.valid if filter == 'valid'
        return Voucher.invalid if filter == 'invalid'
        Voucher.all
      end

    end
  end
end
