require "test_helper"

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_sessions_create_url
    assert_response :success
  end

  test "should get logout" do
    get api_v1_sessions_logout_url
    assert_response :success
  end
end
