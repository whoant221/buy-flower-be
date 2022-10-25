module AdminAuthenticateService

  class Login
    def initialize(username: , password:)
      @username = username
      @password = password
    end

    def success?
      admin
    end

    def token
      @token ||= (success? ? Token.generate(admin: admin) : nil)
    end

    def admin
      @admin ||= Admin.find_by(username: @username)
      raise Constants::InvalidCredentials, I18n.t('services.admin_authenticate_service.login.invalid_credential') unless @admin && @admin.authenticate(@password)

      @admin
    end
  end
end
