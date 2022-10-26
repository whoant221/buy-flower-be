module Api
  module Admin
    class ApiController < ActionController::API
      include ResponseConcern
      include ExceptionConcern
      include RenderConcern

    end
  end
end

