class Api::JobsController < ApplicationController
  def job_status
    @state = Resque::Plugins::Status::Hash.get(params[:id])
    render json: @state
  end
end
