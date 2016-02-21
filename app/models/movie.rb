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

class Movie < ActiveRecord::Base
  
  require 'nokogiri'
  require 'open-uri'
  
  validates :title, :presence => true,
                    :length => { :maximum => 200 }
                    
  validates :year,  :presence => true,
                    :length => { :maximum => 4 }

#Use commingsoon.net
  def self.notify_movies
    if Movie.where(notified:nil).where.not(release_date:nil).size > 0
      time=Config.find_by(parameter:'time')
      time_type=Config.find_by(parameter:'time_type')
      
      if time_type == 'D'
        time = time * 1
      elsif time_type == 'W'
        time = time * 7
      end

      movs = Movie.where(notified:nil).where.not(release_date:nil)
      movs.each do |m|
        if (Date.today >= movs.release_date - time)
        Usermailer.movie_notification_email(m).deliver_later
        m.notified = true
        m.save
      end
      end
    end
  end
  
  def poster 
      page = Nokogiri::HTML(open("http://www.comingsoon.net/movie/"+(self.title.gsub /\s+/, '-').to_s+"-"+self.year.to_s+"#/slide/1"))   
      return page.css('.cover-image img')[0]['src']
  end
  
  def get_release_date

    page = Nokogiri::HTML(open("http://www.comingsoon.net/movie/"+((self.title.delete '/*[]:?\\').gsub /\s+/, '-').to_s+"-"+self.year.to_s+"#/slide/1"))   
    release_date_text = page.css('p')[0].text
    release_date = (release_date_text.split(':')[1]).split('(')[0].gsub(/\s+/, "")
    if release_date != nil
      release_date = Date.strptime(release_date,'%B %e, %Y')
      return release_date
    end
  end  
end
