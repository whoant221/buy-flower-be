module OrderService
  class Client
    def initialize(user:)
      @user = user
    end

    def filter_order(state)
      @user.orders.where(state: state)
    end

    def create(params, data)
      order = @user.orders.create!(params)

      data.each do |key|
        flower = Flower.find_by(id: key[:flower_id])
        next if flower.blank?
        flower_detail = FlowerDetail.best_flower(key[:flower_id], key[:amount]).first
        next if flower_detail.blank?
        OrderDetail.create!(amount: key[:amount], flower_detail_id: flower_detail.id, price: flower[:sale_price], order_id: order.id)
        flower_detail.used_count += key[:amount]
        flower_detail.save!
      end
      order.original_price = order.total_sum
      order.save!
    end

  end
end
