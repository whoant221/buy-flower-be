module Api
  module Admin
    class ApiController < ActionController::API
      include Pundit
      include ResponseConcern
      include ExceptionConcern
      include RenderConcern

    end
  end
end

