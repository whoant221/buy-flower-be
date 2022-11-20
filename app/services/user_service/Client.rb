module UserService
  class Client
    def initialize(user:)
      @user = user
    end

    def update(params)
      user.update(params)
    end

    private

    attr_accessor :user

  end
end
