require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get add_movie" do
    get :add_movie
    assert_response :success
  end

end
