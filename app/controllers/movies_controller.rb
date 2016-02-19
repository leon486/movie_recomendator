class MoviesController < ApplicationController
  def home
    @movies = Movie.all()
  end

  def add_movie
  end
end
