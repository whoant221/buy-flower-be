module AdminAuthenticateService

  class Login
    def initialize(username: , password:)
      @username = username
      @password = password
    end

    def success?
      user
    end

    def token
      @token ||= (success? ? Token.generate(user: user) : nil)
    end

    def user
      @user ||= Admin.find_by(username: @username)
      raise Constants::InvalidCredentials, I18n.t('services.admin_authenticate_service.login.invalid_credential') unless @user && @user.authenticate(@password)

      @user
    end
  end
end
