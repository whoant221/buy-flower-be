module Api
  module V1
    class BudsController < ApiController
      def index
        buds = Bud.find_name(bud_params[:name])
        render 'index', locals: {
          buds: buds
        }, formats: [:json], status: :ok
      end

      private

      def bud_params
        params.permit(:name)
      end
    end
  end
end
