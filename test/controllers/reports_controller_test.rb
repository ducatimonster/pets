require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get return_visit" do
    get :return_visit
    assert_response :success
  end

end
