module Api
  module V1
    class VarsController < ApiController

      def color
        render 'api/v1/vars/color', locals: {
          colors: Flower::COLORS
        }, formats: [:json], status: :ok
      end

    end
  end
end
