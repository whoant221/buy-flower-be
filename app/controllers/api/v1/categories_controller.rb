module Api
  module V1
    class CategoriesController < ApiController
      def index
        categories = Category.search(params[:title])

        render 'index', locals: {
          categories: categories,
        }, formats: [:json], status: :ok
      end

      def show
        category = AdminCategoryService::Client.new(id: params[:id]).show

        render 'show', locals: {
          category: category,
        }, formats: [:json], status: :ok
      end
    end
  end
end

