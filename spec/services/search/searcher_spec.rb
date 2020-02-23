require "rails_helper"

describe Search::Searcher do
  describe "#process" do
    it "find by title" do
      create(:movie)
      create(:movie, title: "Toy Story 2")
      movies = Search::Searcher.new(query_params: { "title": "Toy" }).process
      expect(movies.count).to eq(2)
    end

    it "find by overview" do
      create(:movie)
      create(:movie, title: "Frozen", overview: "Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.")
      movies = Search::Searcher.new(query_params: { "overview": "Elsa" }).process
      expect(movies.count).to eq(1)
    end

    it "find by vote_count" do
      create(:movie)
      movies = Search::Searcher.new(query_params: { "vote_count": 11664 }).process
      expect(movies.count).to eq(1)
    end

    it "find by title and overview" do
      create(:movie)
      create(:movie, title: "Toy Story 2")
      create(:movie, title: "Toy Story 3", overview: "When a kid accidentally triggers the universe's most lethal hunters' return to Earth")
      movies = Search::Searcher.new(query_params: { "title": "Toy", "overview": "lethal" }).process
      expect(movies.count).to eq(1)
    end

    it "find by title and vote_count" do
      create(:movie)
      create(:movie, vote_count: 123)
      movies = Search::Searcher.new(query_params: { "title": "Toy", "vote_count": 123 }).process
      expect(movies.count).to eq(1)
    end

    it "find by overview and vote_count" do
      create(:movie)
      create(:movie, vote_count: 123)
      movies = Search::Searcher.new(query_params: { "overview": "Andy", "vote_count": 123 }).process
      expect(movies.count).to eq(1)
    end

    it "doesn't find by overview and vote_count" do
      create(:movie, overview: "When a kid accidentally triggers the universe's most lethal hunters' return to Earth")
      create(:movie, vote_count: 123)
      movies = Search::Searcher.new(query_params: { "overview": "lethal", "vote_count": 123 }).process
      expect(movies.count).to eq(0)
    end
  end
end