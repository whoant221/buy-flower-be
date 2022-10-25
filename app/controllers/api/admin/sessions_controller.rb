module Api
  module Admin
    class SessionsController < ApiController
      def login
        authenticate = AdminAuthenticateService::Login.new(username: params[:username], password: params[:password])
        if authenticate.success?
          render 'login', locals: {
            token: authenticate.token
          }, formats: :json, status: :ok
        end
      rescue Constants::InvalidCredentials => e
        json_response({message: e.message}, :service_unavailable)
      end

    end
  end
end
