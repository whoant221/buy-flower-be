module Api
  module V1
    class ApiController < ActionController::API
      include ResponseConcern
      include ExceptionConcern
      include RenderConcern
    end
  end
end

