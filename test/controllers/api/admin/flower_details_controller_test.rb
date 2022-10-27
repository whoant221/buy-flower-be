require "test_helper"

class Api::Admin::FlowerDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_admin_flower_details_create_url
    assert_response :success
  end

  test "should get update" do
    get api_admin_flower_details_update_url
    assert_response :success
  end

  test "should get index" do
    get api_admin_flower_details_index_url
    assert_response :success
  end

  test "should get show" do
    get api_admin_flower_details_show_url
    assert_response :success
  end
end
