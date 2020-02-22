module MoviePresenter
  class Create
    attr_reader :params, :body, :response

    def initialize(params:)
      @params = params.permit!.to_h
      @response = { message: "something went wrong", status: 400 }
      @body = @params.fetch(:body, {})
    end

    def missing_movie_id?
      body.dig("movie_id").blank?
    end

    def empty_movie_id
      { json: { status: "422", message: "Must provide a movie id" }, status: :unprocessable_entity }
    end

    def create_movie
      payload = Movies::Finder.new(tmdb_id: body.dig("movie_id")).process
      return { json: { status: "422", message: "Must provide a movie id" }, status: :unprocessable_entity } if payload.blank?

      movie = Movies::Mapper.new(payload: payload).process

      if movie.save
        { json: { status: "200", message: "Movie created", movie: movie.as_json }, status: :ok }
      else
        message = "The movie is missing one or more required fields: title, overview, vote_count, poster_path, release_date"
        { json: { status: "422", message: message }, status: :unprocessable_entity }
      end
    end
  end
end