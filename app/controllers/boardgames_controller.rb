class BoardgamesController < ApplicationController
  def index
  end

  def fetch
  end

  private

  def boardgame_params
    params.expect(boardgame: [:destiny, :id, :type, :page, :name, :username, :query])
  end
end
