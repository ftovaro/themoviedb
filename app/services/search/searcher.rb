module Search
  class Searcher
    attr_reader :query_params, :title, :overview, :vote_count
    attr_accessor :movies

    def initialize(query_params:)
      @query_params = query_params
      @title = query_params.dig(:title)
      @overview = query_params.dig(:overview)
      @vote_count = query_params.dig(:vote_count)
      @movies = []
    end

    def process
      return [] if query_params.blank?
      @movies = find_with_title
      @movies = find_with_overview
      @movies = find_with_vote_count

      movies.to_a
    end

    def find_with_title
      return [] if title.blank?

      Movie.where("title ILIKE '%#{title}%'")
    end

    def find_with_overview
      return movies if overview.blank?

      if movies.blank?
        Movie
      else
        movies
      end.where("overview ILIKE '%#{overview}%'")
    end

    def find_with_vote_count
      return movies if vote_count.blank?

      if movies.blank?
        Movie
      else
        movies
      end.where("vote_count = #{vote_count}")
    end
  end
end
