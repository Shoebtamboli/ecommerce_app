require "test_helper"

class Admin::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_products_index_url
    assert_response :success
  end
end
