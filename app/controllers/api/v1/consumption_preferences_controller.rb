class Api::V1::ConsumptionPreferencesController < ApplicationController

  def index
    @consumption_preferences = ConsumptionPreference.all
    render json: @consumption_preferences
  end

  def consumption_preference
    @consumption_preference = ConsumptionPreference.find_by(twitter_account_id: params["twitter_account_id"])
    render json: @consumption_preference
  end
end
