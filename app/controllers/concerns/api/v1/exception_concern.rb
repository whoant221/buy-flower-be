module Api
  module V1
    module ExceptionConcern
      extend ActiveSupport::Concern

      included do
        rescue_from Pundit::NotAuthorizedError, with: :render_pundit_errors
        rescue_from Exceptions::Unauthorized, with: :render_unauthorized
        rescue_from ActiveRecord::RecordNotFound, with: :render_unprocessable_entity
        rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
        rescue_from Exceptions::InvalidCredentials, with: :render_not_acceptable
        rescue_from Exceptions::OrderInvalid, with: :render_not_acceptable
        rescue_from Exceptions::ShoppingCartBlank, with: :render_not_acceptable
        rescue_from Exceptions::TimeInvalid, with: :render_not_acceptable
        rescue_from Exceptions::DataInvalid, with: :render_not_acceptable
        rescue_from Exceptions::ExchangeVoucherError, with: :render_not_acceptable
        rescue_from Exceptions::UseVoucherInvalid, with: :render_not_acceptable
        rescue_from Exceptions::NotEnoughPoint, with: :render_not_acceptable
        rescue_from Exceptions::NotEnoughBud, with: :render_not_acceptable
      end
    end
  end
end
