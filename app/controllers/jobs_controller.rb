class JobsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    render_success @jobs
  end

  def show
    render_success @job
  end

  def create
    if @job.save
      render_success @job
    else
      render_errors @job
    end
  end

  def update
    if @job.update job_params
      render_success @job
    else
      render_errors @job
    end
  end

  def destroy
    render_success @job.destroy
  end

  private

  def job_params
    permitted_params = params.require(:job).permit(:title, :start_date, :end_date, :city, :description, :company_name, :company_id)
    permitted_params[:user_id] = current_user.id
    permitted_params
  end
end
