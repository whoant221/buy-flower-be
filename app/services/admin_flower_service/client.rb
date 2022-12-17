module AdminFlowerService
  class Client

    def initialize(params: {}, id: nil)
      @params = params
      @id = id
    end

    def create(bud_data)
      Flower.transaction do
        flower = Flower.create!(params)
        bud_data.each do |val|
          bud = Bud.find_by(id: val[:id])
          next unless bud
          FlowerBud.create!(flower: flower, bud: bud, count: val[:count])
        end
        flower
      end
    end

    def show
      flower
    end

    def update(bud_data)
      Flower.transaction do
        flower.buds.destroy_all
        bud_data.each do |val|
          bud = Bud.find_by(id: val[:id])
          next unless bud
          FlowerBud.create!(flower: flower, bud: bud, count: val[:count])
        end
        flower.update!(params)
        flower
      end

    rescue Exception
      raise Exceptions::CategoryInvalid, I18n.t('services.admin_flower_service.invalid_category')
    end

    private

    attr_accessor :params, :id

    def flower
      flower ||= Flower.find_by(id: id)
      raise ActiveRecord::RecordNotFound, I18n.t('services.admin_flower_service.not_exists') unless flower

      flower
    end

  end
end
