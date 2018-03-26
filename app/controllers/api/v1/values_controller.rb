class Api::V1::ValuesController < ApplicationController

  def index
    @values = Value.all
    render json: @values
  end

  def value
    @value = Value.find_by(twitter_account_id: params["twitter_account_id"])
    render json: @value
  end
end
