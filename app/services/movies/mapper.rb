module Movies
  class Mapper
    attr_reader :payload, :movie

    def initialize(payload:)
      @payload = payload
      @movie = Movie.new
    end

    def process
      movie.title = title
      movie.overview = overview
      movie.vote_count = vote_count
      movie.poster_path = poster_path
      movie.release_date = release_date
      movie.tmdb_id = tmdb_id
      movie
    end

    def title
      payload.dig("title")
    end

    def overview
      payload.dig("overview")
    end

    def vote_count
      payload.dig("vote_count")
    end

    def poster_path
      payload.dig("poster_path")
    end

    def release_date
      payload.dig("release_date")
    end

    def tmdb_id
      payload.dig("id")
    end
  end
end