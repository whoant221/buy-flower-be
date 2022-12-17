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

      def update
        bud.update!(bud_params)
        render json: {}, status: :accepted
      end

      private

      def bud
        @bud ||= Bud.find_by(id: params[:id])
        raise ActiveRecord::RecordNotFound, I18n.t('controller.concerns.api.v1.bud.not_exists') unless @bud

        @bud
      end

      def bud_params
        params.permit(:name, :count)
      end

    end
  end
end
