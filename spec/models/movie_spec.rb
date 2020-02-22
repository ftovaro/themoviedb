require "rails_helper"

describe Movie do
  subject(:movie) { create(:movie) }

  context "basic unit tests" do
    it "has a title" do
      subject.title = "test"
      expect(subject.title).to eq("test")
    end
  end
end