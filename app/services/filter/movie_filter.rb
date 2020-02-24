module Filter
  class MovieFilter
    attr_reader :query_params, :filter
    attr_accessor :movies

    def initialize(query_params:)
      @query_params = query_params
      @filter = query_params.dig(:time)
      @movies = []
    end

    def process
      return [] if query_params.blank?
      @movies = filter_movies

      movies.to_a
    end

    def filter_movies
      case filter
      when "tomorrow"
        return Movie.where(release_date: Date.tomorrow)
      when "next-week"
        start_day = Date.current.next_week(:monday)
        end_day = Date.current.next_week(:sunday)
      when "next-month"
        start_day = Date.today.next_month.at_beginning_of_month
        end_day = Date.today.next_month.end_of_month
      when "custom-range"
        range = query_params.dig(:range)
        start_day, end_day = range.split(":")
      end
      Movie.where(release_date: start_day..end_day)
    end
  end
end
