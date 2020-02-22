require "rails_helper"

describe Movies::Finder do
  describe "#process" do
    subject do
      Movies::Finder.new(tmdb_id: 1).process
    end

    it "return true" do
      expect(subject).to eq(true)
    end
  end
end