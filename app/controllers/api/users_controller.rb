class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.password === @user.password_confirmation
      @user.save
      render json: @user
    else
      head :unprocessable_entity
    end
  end
end

