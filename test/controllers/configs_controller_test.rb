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

require 'test_helper'

class ConfigsControllerTest < ActionController::TestCase
  test "should get save" do
    get :save
    assert_response :success
  end

end
