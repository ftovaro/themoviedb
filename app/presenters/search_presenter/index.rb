module SearchPresenter
  class Index
    attr_reader :params

    def initialize(params:)
      @params = params.permit!.to_h
    end

    def empty_params?
      params.dig("title").blank? && params.dig("overview").blank? && params.dig("vote_count").blank?
    end

    def no_params_requested
      { json: { status: "422", message: "Must provide at least one param to search", movies: [] }, status: :unprocessable_entity }
    end

    def find_movies
      movies = Search::Searcher.new(query_params: params).process
      { json: { status: "200", message: "Movies found", movies: movies }, status: :ok }
    end
  end
end