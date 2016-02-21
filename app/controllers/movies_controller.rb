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
#  active       :boolean
#

class MoviesController < ApplicationController
  def home
    Movie.notify_movies
    @c = Config.all()
    @movies = Movie.where(active: true)
  end
  
  def get_release_date
    m = Movie.new
    m.title = params[:title]
    m.year = params[:year]
    if request.xhr?
      render :json => {
                         :release_date => m.get_release_date
                      }
    end
    return 
  end
    
  
  def add_movie
    @m = Movie.find_or_initialize_by(title:params[:title],year:params[:year])
    @m.title = params[:title]
    @m.year = params[:year]
    @m.active = true
    @m.notified = false
    @m.release_date = params[:release_date]
    @m.save
    if request.xhr?
      render :json => {
                         :movie => @m,
                         :poster => @m.poster
                      }
    end
  end
  
  def deactivate
    m = Movie.find_by(id:params[:id])
    m.active = false
    m.save
    if request.xhr?
      render :json => { :movie => m
      }
    end
  end
    
end
