require "rails_helper"

describe Filter::MovieFilter do
  describe "#process" do
    it "filter by tomorrow" do
      create(:movie, title: "Toy Story 2", release_date: Date.tomorrow)
      movies = Filter::MovieFilter.new(query_params: { "time": "tomorrow" }).process
      expect(movies.count).to eq(1)
    end

    it "filter by next week" do
      create(:movie, title: "Toy Story 2", release_date: Date.current.next_week(:monday))
      create(:movie, title: "Toy Story 3", release_date: Date.current.next_week(:tuesday))
      movies = Filter::MovieFilter.new(query_params: { "time": "next-week" }).process
      expect(movies.count).to eq(2)
    end

    it "filter by next month" do
      create(:movie, title: "Toy Story 2", release_date: Date.today.next_month.at_beginning_of_month + 1.days)
      create(:movie, title: "Toy Story 3", release_date: Date.today.next_month.at_beginning_of_month + 3.days)
      create(:movie, title: "Toy Story 4", release_date: Date.today.next_month.at_beginning_of_month + 10.days)
      movies = Filter::MovieFilter.new(query_params: { "time": "next-month" }).process
      expect(movies.count).to eq(3)
    end

    it "filter by custom range" do
      create(:movie, title: "Toy Story 2", release_date: Date.new(2020, 06, 21))
      create(:movie, title: "Toy Story 3", release_date: Date.new(2020, 10, 15))
      movies = Filter::MovieFilter.new(query_params: { "time": "custom-range", "range": "20-06-2020:15-10-2020" }).process
      expect(movies.count).to eq(2)
    end
  end
end