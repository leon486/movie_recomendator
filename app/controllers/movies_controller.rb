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
   # notify_movies()
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
    
  def notify_movies
    movs = Movie.where.not(notified:true).where.not(release_date:nil).where(active:true)
    if movs.size > 0
      time=Config.find_by(parameter:'time')
      time_type=Config.find_by(parameter:'time_type')
      
      if time_type == 'D'
        time = time * 1
      elsif time_type == 'W'
        time = time * 7
      end
      Usermailer.movie_notification_email(3).deliver_now
      movs.each do |m|
        if (Date.today >= movs.release_date - time)
        Usermailer.movie_notification_email(m).deliver_now
        m.notified = true
        m.save
      end
      end
    end
  end
end
