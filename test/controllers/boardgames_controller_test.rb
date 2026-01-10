require "test_helper"
require "mocha/minitest"

class BoardgamesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get boardgames_url
    assert_response :success
  end

  test "should fetch boardgame with valid params" do
    params = { boardgame: { destiny: 'thing', id: '12345' } }
    mock_response = { 'id' => '12345', 'name' => 'Catan' }

    api_mock = mock
    api_mock.stubs(:thing).returns({ 'items' => { 'item' => mock_response } })
    BggRemote.stubs(:api).returns(api_mock)

    get fetch_boardgames_url, params: params, headers: { "Accept" => "text/vnd.turbo-stream.html" }

    assert_response :success
    assert_match "turbo-stream", response.media_type
  end

  test "should redirect with alert when boardgame not found" do
    params = { boardgame: { destiny: 'thing', id: '99999' } }

    api_mock = mock
    api_mock.stubs(:thing).returns(nil)
    BggRemote.stubs(:api).returns(api_mock)

    get fetch_boardgames_url, params: params

    assert_redirected_to boardgames_path
  end

  test "should fetch hot items with valid params" do
    params = { boardgame: { destiny: 'hot_items', type: 'boardgame' } }
    mock_response = [
      {
        'id' => '1',
        'rank' => '1',
        'name' => { 'value' => 'Popular Game' },
        'thumbnail' => { 'value' => 'http://example.com/image.jpg' },
        'yearpublished' => { 'value' => '2020' }
      }
    ]

    api_mock = mock
    api_mock.stubs(:hot_items).returns({ 'items' => { 'item' => mock_response } })
    BggRemote.stubs(:api).returns(api_mock)

    get fetch_boardgames_url, params: params, headers: { "Accept" => "text/vnd.turbo-stream.html" }

    assert_response :success
    assert_match "turbo-stream", response.media_type
  end
end
