class Api::V1::PersonalitiesController < ApplicationController

  def index
    @personalities = Personality.all
    render json: @personalities
  end

  def show
    @personality = Personality.find(params[:id])
    render json: @personality
  end
end
