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
  end
end