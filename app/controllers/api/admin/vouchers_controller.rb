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

      def destroy
        authorize voucher, :destroy?
        voucher.destroy!

        render json: {}, status: :ok
      end

      private

      def voucher_params
        params.permit(:code, :content, :discount, :effective_at, :expiration_at, :limit_count, :max_amount, :threshold, :title, :point)
      end

      def filter_voucher(filter)
        return Voucher.filter_valid if filter == 'valid'
        return Voucher.invalid if filter == 'invalid'
        Voucher.all
      end

      def voucher
        @voucher ||= Voucher.find_by(code: params[:code])
        raise ActiveRecord::RecordNotFound, I18n.t('controller.concerns.api.v1.voucher.not_exists') unless @voucher

        @voucher
      end

    end
  end
end
