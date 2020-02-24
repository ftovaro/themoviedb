require "httparty"

module Movies
  class Finder
    attr_reader :tmdb_id

    def initialize(tmdb_id:)
      @tmdb_id = tmdb_id
    end

    def process
      response = HTTParty.get(url)
      response.body
    end

    def url
      "https://api.themoviedb.org/3/movie/#{tmdb_id}?api_key=#{Rails.application.credentials[:moviedb_api_key]}"
    end
  end
end
