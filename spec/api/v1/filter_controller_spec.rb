require "rails_helper"

describe Api::V1::FilterController do
  describe "#index" do
    let!(:movie) { create(:movie) }

    context "when send a valid payload" do
      before(:each) do
        expect_any_instance_of(Api::V1::FilterController).to receive(:authorized_token).and_return("sampletoken")
      end

      it "filter by tomorrow" do
        create(:movie, title: "Toy Story 2", release_date: Date.tomorrow)
        get "/api/v1/movies/filter?time=tomorrow", headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).dig("movies").count).to eq(1)
      end

      it "filter by next week," do
        create(:movie, title: "Toy Story 2", release_date: Date.current.next_week(:monday))
        create(:movie, title: "Toy Story 3", release_date: Date.current.next_week(:tuesday))
        get "/api/v1/movies/filter?time=next-week", headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).dig("movies").count).to eq(2)
      end

      it "filter by next month" do
        create(:movie, title: "Toy Story 2", release_date: Date.today.next_month.at_beginning_of_month + 1.days)
        create(:movie, title: "Toy Story 3", release_date: Date.today.next_month.at_beginning_of_month + 3.days)
        create(:movie, title: "Toy Story 4", release_date: Date.today.next_month.at_beginning_of_month + 10.days)
        get "/api/v1/movies/filter?time=next-month", headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).dig("movies").count).to eq(3)
      end

      it "filter by custom range" do
        create(:movie, title: "Toy Story 2", release_date: Date.new(2020, 06, 21))
        create(:movie, title: "Toy Story 3", release_date: Date.new(2020, 10, 15))
        get "/api/v1/movies/filter?time=custom-range&range=20-06-2020:15-10-2020", headers: { "X-Api-Key": "sampletoken" }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).dig("movies").count).to eq(2)
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
