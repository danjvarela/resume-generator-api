class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:show, :update, :destroy]

  def index
    render_success(current_user.jobs)
  end

  def show
    render_success(@job)
  end

  def create
    job = Job.create job_params

    if job.persisted?
      render_success(job)
    else
      render_errors(job)
    end
  end

  def update
    if @job.update job_params
      render_success(@job)
    else
      render_errors(@job)
    end
  end

  def destroy
    render_success(@job.destroy)
  end

  private

  def job_params
    params.require(:job).permit(:title, :start_date, :end_date, :city, :description, :company_id).merge({user_id: current_user.id})
  end

  def set_job
    @job = Job.find params[:id]
  end
end
