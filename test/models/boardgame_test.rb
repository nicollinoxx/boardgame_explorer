require "test_helper"
require "mocha/minitest"

class BoardgameTest < ActiveSupport::TestCase
  test "fetch returns nil for invalid destiny" do
    boardgame = Boardgame.new
    result = boardgame.fetch(destiny: 'invalid_destiny', id: '123')

    assert_nil result
  end

  test "fetch calls thing endpoint for thing destiny" do
    params = { destiny: 'thing', id: '12345' }
    mock_response = { 'items' => { 'item' => { 'id' => '12345', 'name' => 'Catan' } } }

    api_mock = mock
    api_mock.stubs(:thing).with(id: '12345').returns(mock_response)
    BggRemote.stubs(:api).returns(api_mock)

    boardgame = Boardgame.new
    result = boardgame.fetch(params)

    assert_equal({ 'id' => '12345', 'name' => 'Catan' }, result)
  end

  test "fetch calls hot_items endpoint for hot_items destiny" do
    params = { destiny: 'hot_items', type: 'boardgame' }
    mock_response = { 'items' => { 'item' => { 'id' => '1', 'name' => 'Popular' } } }

    api_mock = mock
    api_mock.stubs(:hot_items).with(type: 'boardgame').returns(mock_response)
    BggRemote.stubs(:api).returns(api_mock)

    boardgame = Boardgame.new
    result = boardgame.fetch(params)

    assert_equal({ 'id' => '1', 'name' => 'Popular' }, result)
  end

  test "fetch returns nil when API returns nil" do
    params = { destiny: 'thing', id: '99999' }

    api_mock = mock
    api_mock.stubs(:thing).returns(nil)
    BggRemote.stubs(:api).returns(api_mock)

    boardgame = Boardgame.new
    result = boardgame.fetch(params)

    assert_nil result
  end

  test "fetch caches results" do
    params = { destiny: 'thing', id: '12345' }
    mock_response = { 'items' => { 'item' => { 'id' => '12345', 'name' => 'Catan' } } }

    api_mock = mock
    api_mock.stubs(:thing).returns(mock_response)
    BggRemote.stubs(:api).returns(api_mock)

    boardgame = Boardgame.new

    # First call should hit the API
    result1 = boardgame.fetch(params)
    # Second call should use cache (API shouldn't be called again)
    result2 = boardgame.fetch(params)

    assert_equal result1, result2
    assert_equal({ 'id' => '12345', 'name' => 'Catan' }, result1)
  end
end
