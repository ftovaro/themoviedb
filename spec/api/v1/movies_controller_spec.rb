require "rails_helper"

describe Api::V1::MoviesController do
  let(:moviedb_payload) do
    YAML.load_file("#{Rails.root}/spec/services/movies/moviedb_payload.json")
  end

  let(:movie) { build(:movie) }

  before do
    body = moviedb_payload.to_json
    WebMock.disable_net_connect!
    stub_request(:get, /api.themoviedb.org/).
    to_return(status: 200, body: body, headers: {})
    WebMock.allow_net_connect!
  end

  describe "#create" do
    context "when the token is missing" do
      it "returns 401" do
        post "/api/v1/movies", params: {}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when send a valid payload" do
      before(:each) do
        expect_any_instance_of(Api::V1::MoviesController).to receive(:authorized_token).and_return("sampletoken")
      end

      it "sends a movie_id" do
        expect_any_instance_of(Movies::Mapper).to receive(:process).and_return(movie)
        post "/api/v1/movies", params: { body: { movie_id: 862 } }, headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).dig("movie", "tmdb_id")).to eq(862)
        expect(JSON.parse(response.body).dig("movie", "title")).to eq("Toy Story")
        expect(JSON.parse(response.body).dig("movie", "vote_count")).to eq(11664)
        expect(Movie.count).to eq(1)
      end
    end

    context "when send an invalid payload" do
      before(:each) do
        expect_any_instance_of(Api::V1::MoviesController).to receive(:authorized_token).and_return("sampletoken")
      end

      it "does not send a movie_id and returns 422" do
        post "/api/v1/movies", params: { body: {} }, headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "movie selected doesn't have title" do
        movie.title = ""
        expect_any_instance_of(Movies::Mapper).to receive(:process).and_return(movie)
        post "/api/v1/movies", params: { body: { movie_id: 862 } }, headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body).dig("message")).to eq("The movie is missing one or more required fields: title, overview, vote_count, poster_path, release_date")
      end
    end
  end
end
