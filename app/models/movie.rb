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
#

class Movie < ActiveRecord::Base
  validates :title, :presence => true,
                    :length => { :maximum => 200 }
                    
  validates :year,  :presence => true,
                    :length => { :maximum => 4 }
end
