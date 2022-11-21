module Api
  module Admin
    class BudsController < ApiController

      def create
        bud = Bud.create!(bud_params)
        render 'create', locals: {
          bud: bud
        }, formats: [:json], status: :ok
      end

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
