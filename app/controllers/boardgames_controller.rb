class BoardgamesController < ApplicationController
  def index
  end

  def fetch
    @response = Boardgame.new.fetch(boardgame_params.compact_blank)
  end

  private

  def boardgame_params
    params.expect(boardgame: [:destiny, :id, :type, :page, :name, :username, :query])
  end
end
