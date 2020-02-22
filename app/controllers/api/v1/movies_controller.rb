module Api
  module V1
    class MoviesController < Api::BaseController
      skip_before_action :verify_authenticity_token
      # before_action :authenticate_token
      # respond_to :json

      def create
        render json: { message: "Movie created" }, status: 200
      end
    end
  end
end