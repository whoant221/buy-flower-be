module Api
  module V1
    class FlowersController < ApiController
      def index
        flowers = Flower.search(params[:color], params[:price], params[:name], params[:category_id], params[:bud_id], params[:order_by])

        render 'index', locals: {
          flowers: flowers
        }, formats: [:json], status: :ok
      end

      def show
        flower = FlowerService::Client.new(id: params[:id]).show

        render 'show', locals: {
          flower: flower
        }, formats: [:json], status: :ok
      end
    end
  end
end
