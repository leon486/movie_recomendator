# == Schema Information
#
# Table name: configs
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
    c_notification_status    = Config.find_or_initialize_by(parameter:'notification_status')
    c_time      = Config.find_or_initialize_by(parameter:'time')
    c_time_type = Config.find_or_initialize_by(parameter:'time_type')
    c_emails    = Config.find_or_initialize_by(parameter:'emails')
    
    c_notification_status.value = params[:notification_status]
    c_notification_status.save
    
    c_time.value = params[:time]
    c_time.save
    
    c_time_type.value = params[:time_type]
    c_time_type.save
    
    c_emails.value = params[:emails]
    c_emails.save
  end
end
