module AdminAuthenticateService
  class Token
    def self.generate(admin:)
      payload = {
        admin_id: admin.id
      }

      JsonWebToken.encode(payload)
    end
  end
end
