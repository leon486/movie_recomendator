class MoviesController < ApplicationController
  def home
    @movies = Movie.all()
  end

  def add_movie
    m = Movie.find_or_initialize_by(title:params[:title],year:params[:year])
    m.title = params[:title]
    m.year = params[:year]
    m.release_date = params[:release_date]
    m.save
  end
  
  def delete
    Movie.delete(params[:id]) 
  end
end
