module Api
  module Admin
    class CategoriesController < ApiController
      def create
        category = AdminCategoryService::Client.new.create(category_params)
        render 'create', locals: {
          category: category,
        }, formats: [:json], status: :created
        # rescue Exceptions::RecordExists => e
        #   json_response({ message: e.message }, :unprocessable_entity)
      end

      def index
        category = Category.find(params[:id])
        render 'index', locals: {
          category: category,
        }, formats: [:json], status: :ok
      end

      private

      def category_params
        params.permit(:title)
      end
    end
  end
end
