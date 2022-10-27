module Api
  module Admin
    class FlowerDetailsController < ApiController
      def create
        AdminFlowerDetailService::Client.new(params: flower_detail_params).create

        head :created
      end

      def update
      end

      def index
      end

      def show
      end

      private

      def flower_detail_params
        params.permit(:count, :used_count, :expiration_at, :flower_id)
      end

    end
  end
end
