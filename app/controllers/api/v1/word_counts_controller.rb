class Api::V1::WordCountsController < ApplicationController

  def index
    @word_counts = WordCount.all
    render json: @word_counts
  end

  def show
    @word_count = WordCount.find(params[:id])
    render json: @word_count
  end
end
