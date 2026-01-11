module BoardgamesHelper
  def normalize(boardgame)
    boardgame.is_a?(Array) ? boardgame.first : boardgame
  end

  def primary_name(item)
    name = item["name"]
    return name["value"] unless name.is_a?(Array)

    name.find { |n| n["type"] == "primary" }&.dig("value")
  end

  def alternate_name(item)
    return unless item["name"].is_a?(Array)

    item["name"].find { |n| n["type"] == "alternate" }&.dig("value")
  end

  def players_range(item)
    min = item.dig("minplayers", "value")
    max = item.dig("maxplayers", "value")
    [min, max].compact.join(" – ")
  end

  def categories(item)
    item["link"]
      &.select { |l| l["type"] == "boardgamecategory" }
      &.map { |l| l["value"] } || []
  end

  def mechanics(item)
    item["link"]
      &.select { |l| l["type"] == "boardgamemechanic" }
      &.map { |l| l["value"] } || []
  end

  def designer(item)
    item["link"]
      &.find { |l| l["type"] == "boardgamedesigner" }
      &.dig("value")
  end

  def publisher(item)
    item["link"]
      &.find { |l| l["type"] == "boardgamepublisher" }
      &.dig("value")
  end
end
