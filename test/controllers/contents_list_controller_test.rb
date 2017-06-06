require 'test_helper'

class ContentsListControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
