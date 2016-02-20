# == Schema Information
#
# Table name: movies
#
#  id           :integer          not null, primary key
#  title        :string
#  year         :integer
#  release_date :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  notified     :boolean
#

class MoviesController < ApplicationController

  def home
    @c = Config.all()
    @movies = Movie.all()
  end

  def add_movie
    @m = Movie.find_or_initialize_by(title:params[:title],year:params[:year])
    @m.title = params[:title]
    @m.year = params[:year]
    @m.release_date = params[:release_date]
    if @m.save
      format.js { render :json => @m,:status => :created, :location => @m }
    end
  end
  
  def delete
    m = Movie.find_by(id:params[:id]).destroy
  end
end
