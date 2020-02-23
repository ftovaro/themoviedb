module Api
  module V1
    class SearchController < Api::BaseController
      skip_before_action :verify_authenticity_token
      before_action :authenticate_token

      def index
        presenter = SearchPresenter::Index.new(params: params)
        return render presenter.no_params_requested if presenter.empty_params?

        render presenter.find_movies
      end
    end
  end
end