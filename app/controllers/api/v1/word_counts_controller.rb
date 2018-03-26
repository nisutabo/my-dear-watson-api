class Api::V1::WordCountsController < ApplicationController

  def index
    @word_counts = WordCount.all
    render json: @word_counts
  end

  def word_count
    @word_count = WordCount.find_by(twitter_account_id: params["twitter_account_id"])
    render json: @word_count
  end
end
