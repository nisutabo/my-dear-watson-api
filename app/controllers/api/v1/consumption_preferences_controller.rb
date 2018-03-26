class Api::V1::ConsumptionPreferencesController < ApplicationController

  def index
    @consumption_preferences = ConsumptionPreference.all
    render json: @consumption_preferences
  end

  def show
    @consumption_preference = ConsumptionPreference.find(params[:id])
    render json: @consumption_preference
  end
end
