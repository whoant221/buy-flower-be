module Api
  module V1
    class ApiController < ActionController::API
      include ResponseConcern
      include ExceptionConcern
    end
  end
end

