# == Schema Information
#
# Table name: configurations
#
#  id          :integer          not null, primary key
#  parameter   :string
#  value       :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ConfigsController < ApplicationController
  def save
  end
end
