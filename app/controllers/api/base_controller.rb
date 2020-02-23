module Api
  class BaseController < ActionController::Base
    protect_from_forgery with: :exception

    def authenticate_token
      token = request.headers["X-Api-Key"]
      render json: { status: "401", message: "Unauthorized" }, status: :unauthorized if token != authorized_token
    end

    def authorized_token
      Rails.application.credentials[:app_token]
    end
  end
end
