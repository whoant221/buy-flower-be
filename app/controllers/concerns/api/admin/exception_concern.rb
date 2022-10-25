module Api
  module Admin
    module ExceptionConcern
      extend ActiveSupport::Concern

      included do
        rescue_from Exceptions::RecordExists do |e|
          json_response({ message: e.message }, :unprocessable_entity)
        end

        rescue_from StandardError do |e|
          json_response({ message: e.message }, :unprocessable_entity)
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          json_response({ message: e.message }, :not_found)
        end

      end
    end
  end
end
