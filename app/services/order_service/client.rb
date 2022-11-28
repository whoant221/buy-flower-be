module OrderService
  class Client
    def initialize(user:)
      @user = user
    end

    def create(params, additional_data)
      shopping_carts = shopping_cart_service.all_items
      raise Exceptions::ShoppingCartBlank, I18n.t('services.order_service.shopping_cart_blank') if shopping_carts.count == 0

      ShoppingCart.transaction do
        ::Order.transaction do
          order = user.orders.create!(params)
          shopping_carts.each do |key|
            flower = Flower.find_by(id: key[:flower_id])
            next if flower.blank?
            OrderDetail.create!(amount: key[:amount], flower: flower, price: flower[:sale_price], order: order)
          end
          order.original_price = order.price
          order.additional_data = additional_data
          shopping_cart_service.destroy_all
          order.save!
          order
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
