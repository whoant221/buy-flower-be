module Api
  module V1
    class VouchersController < ApiController
      def index
        vouchers = Voucher.valid
        render 'index', locals: {
          vouchers: vouchers
        }, formats: [:json], status: :ok
      end
    end
  end
end

