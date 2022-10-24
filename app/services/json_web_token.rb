class JsonWebToken
  class << self
    def encode(payload, exp = 30.days.from_now, secret_key = Rails.application.secrets.secret_key_base)
      payload[:exp] = exp.to_i
      JWT.encode(payload, secret_key)
    end

    def decode(token, secret_key = Rails.application.secrets.secret_key_base)
      body = JWT.decode(token, secret_key)[0]
      HashWithIndifferentAccess.new(body)
    rescue StandardError
      nil
    end
  end
end
