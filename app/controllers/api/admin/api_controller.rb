module Api
  module Admin
    class ApiController < ActionController::API
      include ResponseConcern
      include ExceptionConcern

    end
  end
end

