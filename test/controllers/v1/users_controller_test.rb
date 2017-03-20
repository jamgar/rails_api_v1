require 'test_helper'

class V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get v1_users_new_url
    assert_response :success
  end

end
