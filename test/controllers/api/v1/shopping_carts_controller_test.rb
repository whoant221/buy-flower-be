require "test_helper"

class Api::V1::ShoppingCartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_shopping_carts_index_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_shopping_carts_create_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_shopping_carts_destroy_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_shopping_carts_update_url
    assert_response :success
  end
end
