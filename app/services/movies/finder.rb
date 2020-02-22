module Movies
  class Finder
    attr_reader :tmdb_id

    MOVIE_DB_URL = "https://api.themoviedb.org/3/movie/".freeze
    AUTH_PARAM = "?api_key=#{Rails.application.credentials[:moviedb_api_key]}"

    def initialize(tmdb_id:)
      @tmdb_id = tmdb_id
    end

    def process
      true
    end
  end
end