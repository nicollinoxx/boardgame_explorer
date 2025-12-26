class Boardgame
  include ActiveModel::Model

  DESTINIES = {
    "Thing" => "thing"
  }.freeze

  def fetch params
    Rails.cache.fetch(cache_key(params), expires_in: 2.hours) { dispatch params }
  end

  private

  def dispatch params
    bgg_api = BggRemote.api

    case params[:destiny]
    when "thing" then bgg_api.thing(id: params[:id])&.dig('items', 'item')
    else
      raise ArgumentError, "Unknown destiny: #{params[:destiny]}"
    end
  end

  def cache_key params
    "bgg:#{params[:destiny]}:#{params.slice(:id, :type, :page, :name, :username, :query).to_h}"
  end
end
