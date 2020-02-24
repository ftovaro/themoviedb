module Api
  module V1
    class MoviesController < Api::BaseController
      skip_before_action :verify_authenticity_token
      before_action :authenticate_token, only: :create

      def index
        # I know that this is completly ugly but I did't have time to implement the pagination :(
        movies = Movie.all
        render json: { status: "200", message: "Loaded movies", movies: movies }, status: :ok
      end

      def create
        presenter = MoviePresenter::Create.new(params: params)
        return render presenter.empty_movie_id if presenter.missing_movie_id?
        return render presenter.movie_found if presenter.movie_already_exists?

        render presenter.create_movie
      end
    end
  end
end