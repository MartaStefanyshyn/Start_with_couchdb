class Api::JobsController < ApplicationController
  def index
    @jobs = Job.all
    render json: @jobs
  end
  def show
    @job = Job.find(params[:id])
    render json: @job
  end
  def job_status
    @job = Job.find(params[:id])
    status = Resque::Plugins::Status::Hash.get(@job.job_id)
    while status and !status.completed? && !status.failed?
      sleep 1
      status.inspect
    end
    if status.status = "completed"
      @job.update_attributes status: "completed"
      @job.save
    end

    render json: @job
  end
end
