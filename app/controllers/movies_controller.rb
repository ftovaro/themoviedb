class MoviesController < ApplicationController
  def index
    Movie.all
  end
end