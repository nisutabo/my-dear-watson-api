class Api::V1::NeedsController < ApplicationController

  def index
    @needs = Need.all
    render json: @needs
  end

  def need
    @need = Need.find_by(twitter_account_id: params["twitter_account_id"])
    render json: @need
  end
end
