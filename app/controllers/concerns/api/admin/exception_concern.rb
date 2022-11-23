module Api
  module Admin
    module ExceptionConcern
      extend ActiveSupport::Concern

      included do
        rescue_from Pundit::NotAuthorizedError, with: :render_pundit_errors
        rescue_from ActiveRecord::RecordNotFound, with: :render_unprocessable_entity
        rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
        rescue_from Exceptions::InvalidCredentials, with: :render_not_acceptable
        rescue_from Exceptions::CategoryInvalid, with: :render_unprocessable_entity
      end
    end
  end
end
