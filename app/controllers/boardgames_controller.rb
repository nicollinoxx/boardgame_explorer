class BoardgamesController < ApplicationController
  def index
  end

  def fetch
    @response = Boardgame.new.fetch(boardgame_params.compact_blank)
    redirect_to boardgames_path, alert: "Item not found", status: :see_other unless @response.present?
  end

  private

  def boardgame_params
    params.expect(boardgame: [:destiny, :id, :type])
  end
end
