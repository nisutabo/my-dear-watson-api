class Api::V1::PersonalitiesController < ApplicationController

  def index
    @personalities = Personality.all
    render json: @personalities
  end

  def personality
    @personality = Personality.find_by(twitter_account_id: params["twitter_account_id"])
    render json: @personality
  end
end
