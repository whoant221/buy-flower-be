module Api
  module Admin
    class CategoriesController < ApiController
      def create
        category = AdminCategoryService::Client.new(params: category_params).create

        render 'create', locals: {
          category: category,
        }, formats: [:json], status: :created
      end

      def index
        categories = Category.search(params[:title])

        render 'index', locals: {
          categories: categories,
        }, formats: [:json], status: :ok
      end

      def update
        category = AdminCategoryService::Client.new(params: category_params, id: params[:id]).update

        render 'update', locals: {
          category: category,
        }, formats: [:json], status: :created
      end

      def show
        category = AdminCategoryService::Client.new(id: params[:id]).show

        render 'show', locals: {
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
