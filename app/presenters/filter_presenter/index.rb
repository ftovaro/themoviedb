module FilterPresenter
  class Index
    attr_reader :params

    def initialize(params:)
      @params = params.permit!.to_h
    end

    def empty_params?
      params.dig("time").blank?
    end

    def no_filter_requested
      render json: { status: "200", message: "Loaded movies", movies: Movie.all }, status: :ok
    end

    def filter_movies
      movies = Filter::MovieFilter.new(query_params: params).process
      { json: { status: "200", message: "Movies found", movies: movies }, status: :ok }
    end
  end
end