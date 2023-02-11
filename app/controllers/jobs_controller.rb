class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:show, :update, :destroy]

  def index
    render json: current_user.jobs, root: "data"
  end

  def show
    render json: @job, root: "data"
  end

  def create
    @job = Job.create job_params

    if @job.persisted?
      render json: @job, root: "data"
    else
      render_errors @job, root: "errors"
    end
  end

  def update
    if @job.update job_params
      render json: @job, root: "data"
    else
      render_errors @job
    end
  end

  def destroy
    @job.destroy
    render json: @job, root: "data"
  end

  private

  def job_params
    params.require(:job).permit(:title, :start_date, :end_date, :city, :description, :company_id).merge({user_id: current_user.id})
  end

  def set_job
    @job = Job.find params[:id]
  end
end
