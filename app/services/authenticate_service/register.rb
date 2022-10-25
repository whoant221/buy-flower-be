module AuthenticateService
  class Register
    def initialize(params: {})
      @params = params
    end

    def create
      raise Constants::UserExists, I18n.t('services.authenticate_service.register.exist_user') if exist?
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