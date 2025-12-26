class BoardgamesController < ApplicationController
  before_action :set_boardgame

  def index
  end

  def fetch
    @response = @boardgame.fetch(boardgame_params.compact_blank)
    redirect_to boardgames_path, alert: "Item not found", status: :see_other unless @response.present?
  end

  private

  def boardgame_params
    params.expect(boardgame: [:destiny, :id, :type])
  end

  def set_boardgame
    @boardgame = Boardgame.new
  end
end
