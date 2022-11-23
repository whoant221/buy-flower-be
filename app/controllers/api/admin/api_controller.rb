module Api
  module Admin
    class ApiController < ActionController::API
      include Pundit::Authorization
      include ResponseConcern
      include ExceptionConcern
      include RenderConcern

      private

      def current_user
        @current_user ||= ::Admin.find_by(username: 'admin')
      end

    end
  end
end

