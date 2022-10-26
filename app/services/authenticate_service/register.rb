module AuthenticateService
  class Register
    def initialize(params: {})
      @params = params
    end

    def create
      User.create!(@params)
    end

    private

    def exist?
      user
    end

    def user
      @user ||= User.find_by(email: @params['email'])
    end
  end
end