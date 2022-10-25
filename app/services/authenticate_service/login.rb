module AuthenticateService
  class Login
    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def success?
      user
    end

    def token
      @token ||= (success? ? Token.generate(user: user) : nil)
    end

    def user
      @user ||= User.find_by(email: @email)
      raise Exceptions::InvalidCredentials, I18n.t('services.authenticate_service.login.invalid_credential') unless @user && @user.authenticate(@password)

      @user
    end

  end
end
