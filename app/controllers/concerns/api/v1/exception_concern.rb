module Api
  module V1
    module ExceptionConcern
      extend ActiveSupport::Concern

      included do
        rescue_from ActiveRecord::RecordNotFound do |e|
          json_response({ message: e.message }, :not_found)
        end

        # rescue_from ActiveRecord::RecordInvalid do |e|
        #   json_response({ message: e.message }, :unprocessable_entity)
        # end

        rescue_from AuthenticateService::RegisterUserError do |e|
          json_response({message: e.message}, :ok)
        end

      end
    end
  end
end