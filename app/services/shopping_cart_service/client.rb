module ShoppingCartService
  class Client
    def initialize(user:, params: {})
      @user = user
      @params = params
    end

    def all
      @user.shopping_carts
    end

    def add_new_item
      if exists?
        shopping_cart.amount = @params[:amount]
        shopping_cart.save!
        shopping_cart
      else
        @user.shopping_carts.create!(@params)
      end
    end

    def destroy(flower_id)
      shopping_cart = ShoppingCart.find_by(user: @user, flower_id: flower_id)
      shopping_cart.delete if shopping_cart
    end

    private

    def exists?
      !!shopping_cart
    end

    def shopping_cart
      @shopping_cart ||= ShoppingCart.find_by(user: @user, flower_id: @params[:flower_id])
    end

  end
end