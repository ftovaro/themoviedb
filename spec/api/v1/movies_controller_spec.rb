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

      it "sends a movie_id and returns 200" do
        post "/api/v1/movies", params: { body: { movie_id: 1 } }, headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:ok)
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
    end
  end
end
