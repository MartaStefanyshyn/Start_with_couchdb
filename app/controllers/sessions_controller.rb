class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      puts session[:user_id]
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    puts session[:user_id]
    session[:user_id] = nil
    puts session[:user_id]
    redirect_to root_url, :notice => "Logged out!"
  end
end
