module Api
  module V1
    class FilterController < Api::BaseController
      skip_before_action :verify_authenticity_token
      before_action :authenticate_token

      def index
        presenter = FilterPresenter::Index.new(params: params)
        return render presenter.no_filter_requested if presenter.empty_params?

        render presenter.filter_movies
      end
    end
  end
end