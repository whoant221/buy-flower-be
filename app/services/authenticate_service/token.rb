module AuthenticateService
  class Token
    def self.generate(user:)
      payload = {
        user_id: user.id
      }

      JsonWebToken.encode(payload)
    end
  end
end
