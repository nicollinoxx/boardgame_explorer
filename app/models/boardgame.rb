class Boardgame
  DESTINIES = { 'Thing' => 'thing', 'Hot items' => 'hot_items' }.freeze
  HOT_ITEMS_TYPES = { 'Boardgame' => 'boardgame', 'Rpg' => 'rpg' }.freeze

  def fetch params
    return unless available_destiny_to? params[:destiny]

    Rails.cache.fetch(cache_key(params), expires_in: 2.hours, skip_nil: true) do
      dispatch(params)&.dig('items', 'item')
    end
  end

  private

  def dispatch params
    bgg_api = BggRemote.api

    case params[:destiny]
    when 'thing'     then bgg_api.thing(id: params[:id])
    when 'hot_items' then bgg_api.hot_items(type: params[:type])
    end
  end

  def available_destiny_to? destiny
    ['thing', 'hot_items'].include?(destiny)
  end

  def cache_key params
    "bgg:#{params[:destiny]}:#{params.slice(:id, :type, :page, :name, :username, :query).to_h}"
  end
end
