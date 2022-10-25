module AdminCategoryService
  class Client
    def initialize

    end

    def create(params)
      create_category(params)
    end

    private

    def create_category(params)
      raise Exceptions::RecordExists, I18n.t('services.admin_category_service.category.exists') if exists_title?(params[:title])
      Category.create!(params)
    end

    def exists_title?(title)
      Category.search_title(title).present?
    end

  end
end
