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
  
  def poster 
    
    begin
      page = Nokogiri::HTML(open("http://www.comingsoon.net/movie/"+((self.title.delete '/*[]:?\\').gsub /\s+/, '-').to_s+"-"+self.year.to_s+"#/slide/1"))   
      return page.css('.cover-image img')[0]['src']
    rescue OpenURI::HTTPError
      return ActionController::Base.helpers.asset_path("poster_not_found.gif")
    end
  end
  
  def get_release_date

    begin
      page = Nokogiri::HTML(open("http://www.comingsoon.net/movie/"+((self.title.delete '/*[]:?\\').gsub /\s+/, '-').to_s+"-"+self.year.to_s+"#/slide/1"))   
      release_date_text = page.css('p')[0].text
    rescue OpenURI::HTTPError  
      return nil
    end
    
    release_date = (release_date_text.split(':')[1]).split('(')[0].gsub(/\s+/, "")
    if release_date != nil
      release_date = Date.strptime(release_date,'%B %e, %Y')
      return release_date
    end
  end  
end
