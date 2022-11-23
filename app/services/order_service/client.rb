module OrderService
  class Client
    def initialize(user:)
      @user = user
    end

    def create(params)
      shopping_carts = shopping_cart_service.all
      return if shopping_carts.count == 0

      ShoppingCart.transaction do
        ::Order.transaction do
          order = user.orders.create!(params)
          shopping_carts.each do |key|
            flower = Flower.find_by(id: key[:flower_id])
            next if flower.blank?
            OrderDetail.create!(amount: key[:amount], flower: flower, price: flower[:sale_price], order: order)
          end
          order.original_price = order.price
          shopping_cart_service.destroy_all
          order.save!
        end
      end

    end

    private

    attr_accessor :user

    def shopping_cart_service
      @shopping_cart_service ||= ShoppingCartService::Client.new(user: user)
    end

  end
end
