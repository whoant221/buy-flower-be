module Api
  module Admin
    class FlowersController < ApiController

      def create
        flower = AdminFlowerService::Client.new(params: flower_params).create(params[:bud_data])

        render 'create', locals: {
          flower: flower,
        }, formats: [:json], status: :created
      end

      def index
        flowers = Flower.all

        render 'index', locals: {
          flowers: flowers
        }, formats: [:json], status: :ok
      end

      def show
        flower = AdminFlowerService::Client.new(id: params[:id]).show

        render 'show', locals: {
          flower: flower
        }, formats: [:json], status: :ok
      end

      def update
        flower = AdminFlowerService::Client.new(params: flower_params, id: params[:id]).update

        render 'update', locals: {
          flower: flower
        }, formats: [:json], status: :accepted

      end

      private

      def flower_params
        params.permit(:name, :color, :original_price, :sale_price, :description, images: [], category_ids: [])
      end

    end
  end
end
