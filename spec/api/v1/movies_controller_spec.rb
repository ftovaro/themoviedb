require "rails_helper"

describe Api::V1::MoviesController do

  describe "#create" do
    context "when send a valid payload" do
      it "returns 200" do
        post "/api/v1/movies", params: {}, as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
