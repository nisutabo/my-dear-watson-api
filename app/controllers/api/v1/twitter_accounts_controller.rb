class Api::V1::TwitterAccountsController < ApplicationController

  def index
    @accounts = TwitterAccount.all
    render json: @accounts
  end

  def show
    @account = TwitterAccount.find(params[:id])
    render json: @account
  end

  def create
    @account = TwitterAccount.new(account_params)

    twitter_controller = Api::V1::TwitterApiController.new
    input = twitter_controller.get_tweet_text(@account.handle)

    if input.length > 0
      watson_controller = Api::V1::WatsonApiController.new
      analysis = watson_controller.analyze(input)

      if !analysis.kind_of?(String)
        if @account.save
          word_counts = user.build_word_count(analysis[:word_count])
          word_counts.save

          personalities = user.build_personality(analysis[:personality])
          personalities.save

          needs = user.build_need(analysis[:need])
          needs.save

          values = user.build_value(analysis[:value])
          values.save

          consumption_preferences = user.build_consumption_preference(analysis[:consumption_preference])
          consumption_preferences.save

          return render json: @account
        else
          return render json: {errors: @account.errors.full_messages}, status: 422
        end
      else
        return render json: analysis, status: 422
      end
    else
      return render json: "Please confirm this twitter handle has any tweets", status: 422
    end
  end

  def update
    @account = TwitterAccount.find(params[:id])

    @account.update(account_params)
    if @account.save
      render json: @account
    else
      render json: {errors: @account.errors.full_messages}, status: 422
    end
  end

  def destroy
    @account = TwitterAccount.find(params[:id])
    @account.destroy
    @accounts = TwitterAccount.all
    render json: @accounts
  end

  private

  def account_params
    params.permit(:handle)
  end
end
