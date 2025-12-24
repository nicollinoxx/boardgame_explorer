require "test_helper"

class BoardgamesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get boardgames_index_url
    assert_response :success
  end
end
