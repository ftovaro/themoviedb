require "rails_helper"

describe Api::V1::SearchController do
  describe "#index" do
    let!(:movie) { create(:movie) }

    context "when send a valid payload" do
      before(:each) do
        expect_any_instance_of(Api::V1::SearchController).to receive(:authorized_token).and_return("sampletoken")
      end

      it "search a title" do
        create(:movie, title: "Toy Story 2")
        get "/api/v1/movies/search?title=Toy+Story", headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).dig("movies").count).to eq(2)
      end

      it "search an overview" do
        get "/api/v1/movies/search?overview=Andy", headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).dig("movies").count).to eq(1)
      end

      it "search a vote_count" do
        get "/api/v1/movies/search?vote_count=11664", headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).dig("movies").count).to eq(1)
      end
    end

    context "when send an invalid payload" do
      before(:each) do
        expect_any_instance_of(Api::V1::SearchController).to receive(:authorized_token).and_return("sampletoken")
      end

      it "does not send a params to search and returns 422" do
        get "/api/v1/movies/search", headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
