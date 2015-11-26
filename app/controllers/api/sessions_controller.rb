class Api::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def show
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      render json: {session: session[:user_id]}
    else
      head :forbidden
    end
  end

  def destroy
    session[:user_id] = nil
    head :no_content
  end
end
