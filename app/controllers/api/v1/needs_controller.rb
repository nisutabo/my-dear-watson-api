class Api::V1::NeedsController < ApplicationController

  def index
    @needs = Need.all
    render json: @needs
  end

  def show
    @need = Need.find(params[:id])
    render json: @need
  end
end
