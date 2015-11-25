class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.password === @user.password_confirmation
      @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      flash[:danger] = "Wrong password"
      render "new"
    end
  end
end

