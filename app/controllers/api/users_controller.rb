class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.password === @user.password_confirmation
      if @user.save
         render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      head :unprocessable_entity
    end
  end

  def logged_in
    @user =  User.by_id(key: session[:user_id]).first if session[:user_id]
    if @user
      email = @user.email
      render json: {email: email}
    else
      render json: {email: ''}
    end
  end
end

