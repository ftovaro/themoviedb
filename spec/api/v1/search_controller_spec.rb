require "rails_helper"

describe Api::V1::SearchController do
  describe "#create" do
    let!(:movie) { create(:movie) }

    context "when send a valid payload" do
      before(:each) do
        expect_any_instance_of(Api::V1::SearchController).to receive(:authorized_token).and_return("sampletoken")
      end

      it "sends a movie_id" do
        get "/api/v1/movies/search", params: { body: {} }, headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
