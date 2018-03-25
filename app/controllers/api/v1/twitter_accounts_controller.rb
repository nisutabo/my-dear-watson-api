class Api::V1::TwitterAccountsController < ApplicationController

  def index
    @accounts = TwitterAccount.all
    render json: @accounts
  end

  def show
    
  end

  def create

  end

  def update

  end

  def destroy

  end
end
