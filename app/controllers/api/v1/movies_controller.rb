module Api
  module V1
    class MoviesController < Api::BaseController
      skip_before_action :verify_authenticity_token
      before_action :authenticate_token

      def create
        render json: { message: "Movie created" }, status: 200
      end

      private

      def authenticate_token
        token = request.headers["X-Api-Key"]
        render json: { status: "401", title: "Unauthorized" }, status: :unauthorized if token != authorized_token
      end

      def authorized_token
        Rails.application.credentials[:app_token]
      end
    end
  end
end