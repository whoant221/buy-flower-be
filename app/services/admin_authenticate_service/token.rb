module AdminAuthenticateService
  class Token
    def self.generate(user:)
      payload = {
        admin_id: user.id
      }

      JsonWebToken.encode(payload)
    end
  end
end
