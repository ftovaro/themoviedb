module Api
  module V1
    class SearchController < Api::BaseController
      skip_before_action :verify_authenticity_token
      before_action :authenticate_token

      def index
        # name,​ overview,​ ​or​ vote count
        render json: { status: "200", message: "ok" }, status: :ok
      end
    end
  end
end