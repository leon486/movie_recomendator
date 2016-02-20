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

class ConfigTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
