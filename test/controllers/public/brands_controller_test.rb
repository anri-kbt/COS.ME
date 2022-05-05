require "test_helper"

class Public::BrandsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_brands_index_url
    assert_response :success
  end
end
