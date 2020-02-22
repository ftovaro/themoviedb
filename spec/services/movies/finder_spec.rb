require "rails_helper"

describe Movies::Finder do
  let(:moviedb_payload) do
    YAML.load_file("#{Rails.root}/spec/services/movies/moviedb_payload.json")
  end

  before do
    body = moviedb_payload.to_json
    WebMock.disable_net_connect!
    stub_request(:get, /api.themoviedb.org/).
    to_return(status: 200, body: body, headers: {})
    WebMock.allow_net_connect!
  end

  describe "#process" do
    subject do
      JSON.parse(Movies::Finder.new(tmdb_id: 1).process)
    end

    it "has an id" do
      expect(subject.dig("id")).to eq(moviedb_payload.dig("id"))
    end

    it "has a title" do
      expect(subject.dig("title")).to eq(moviedb_payload.dig("title"))
    end

    it "has a overview" do
      expect(subject.dig("overview")).to eq(moviedb_payload.dig("overview"))
    end

    it "has a vote_count" do
      expect(subject.dig("vote_count")).to eq(moviedb_payload.dig("vote_count"))
    end

    it "has a poster_path" do
      expect(subject.dig("poster_path")).to eq(moviedb_payload.dig("poster_path"))
    end

    it "has a release_date" do
      expect(subject.dig("release_date")).to eq(moviedb_payload.dig("release_date"))
    end
  end
end