module AdminFlowerDetailService
  class Client
    def initialize(params: {})
      @params = params
    end

    def create
      flower = AdminFlowerService::Client.new(id: @params[:flower_id]).show
      flower.flower_details.create!(@params)
    end

    def show

    end

    def update

    end

    private

  end
end
