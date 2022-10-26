module AdminFlowerService
  class Client

    def initialize(params: {}, id: nil)
      @params = params
      @id = id
    end

    def create
      Flower.create!(@params)
    end

    def show
      flower
    end

    def update
      flower.update!(@params)

      flower
    end

    private

    def flower
      flower ||= Flower.find_by(id: @id)
      raise ActiveRecord::RecordNotFound, I18n.t('services.admin_flower_service.not_exists') unless flower

      flower
    end

  end
end
