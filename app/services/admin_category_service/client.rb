module AdminCategoryService
  class Client
    def initialize(params: {}, id: nil)
      @params = params
      @id = id
    end

    def create
      Category.create!(@params)
    end

    def update
      category.update!(@params)

      category
    end

    def show
      category
    end

    def category
      @category ||= Category.find_by(id: @id)
      raise ActiveRecord::RecordNotFound, I18n.t('services.admin_category_service.not_exists') unless @category

      @category
    end

  end
end
