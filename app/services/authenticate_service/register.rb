module AuthenticateService
  class Register
    def initialize(params: {})
      @params = params
    end

    def create
      raise RegisterUserError, I18n.t('services.authenticate_service.register.exist_user') if exist?
      User.create!(@params)
    end

    private

    def exist?
      User.find_by(email: @params['email'])
    end
  end
end