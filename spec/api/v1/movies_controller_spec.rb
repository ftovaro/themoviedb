require "rails_helper"

describe Api::V1::MoviesController do

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

      it "returns 200" do
        post "/api/v1/movies", params: {}, headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:ok)
      end

      it "sends a tmdb_id and returns 200" do
        post "/api/v1/movies", params: { movie: { tmdb_id: 1 } }, headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
