module Api
  module V1
    class ApiController < ActionController::API
      include Pundit::Authorization
      include ResponseConcern
      include ExceptionConcern
      include RenderConcern

      private

      def current_user
        @current_user ||= if decoded_auth_token
                            User.find_by_id(decoded_auth_token[:user_id])
                          end
      end

      def http_auth_header
        @http_auth_header ||= if request.headers['Authorization'].present?
                                request.headers['Authorization'].split(' ').last
                              end
      end

      def decoded_auth_token
        @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
      end

      def signed_in?
        !!current_user
      end

      def required_login
        raise Exceptions::Unauthorized, I18n.t('controller.concerns.api.v1.render_concern.unauthorized') unless signed_in?
      end

    end
  end
end

