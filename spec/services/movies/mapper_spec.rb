require "rails_helper"

describe Movies::Mapper do
  describe "#process" do
    let(:moviedb_payload) do
      YAML.load_file("#{Rails.root}/spec/services/movies/moviedb_payload.json")
    end

    subject do
      Movies::Mapper.new(payload: moviedb_payload).process
    end

    it "maps title" do
      expect(subject.title).to eq(moviedb_payload.dig("title"))
      expect(subject.title).to be_kind_of(String)
    end

    it "maps overview" do
      expect(subject.overview).to eq(moviedb_payload.dig("overview"))
    end

    it "maps vote_count" do
      expect(subject.vote_count).to eq(moviedb_payload.dig("vote_count"))
    end

    it "maps poster_path" do
      expect(subject.poster_path).to eq(moviedb_payload.dig("poster_path"))
    end

    it "maps release_date" do
      expect(subject.release_date.strftime("%Y-%m-%d")).to eq(moviedb_payload.dig("release_date"))
    end
  end
end