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
    @account = TwitterAccount.find_or_create_by(account_params)
    render json: @account
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
    render index # correct?
  end

  private

  def account_params
    params.permit(:handle)
  end
end
