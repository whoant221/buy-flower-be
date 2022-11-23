module OrderService
  class Client
    def initialize(user:)
      @user = user
    end

    def create(params, data)
      order = @user.orders.create!(params)

      data.each do |key|
        flower = Flower.find_by(id: key[:flower_id])
        next if flower.blank?
        OrderDetail.create!(amount: key[:amount], flower: flower, price: flower[:sale_price], order: order)
      end
      order.original_price = order.price
      order.save!
    end

  end
end
