class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :job_not_found

  def index
    @jobs = current_user.jobs
    respond_with @jobs
  end

  def show
    respond_with @job
  end

  def create
    @job = Job.create job_params

    if @job.persisted?
      respond_with @job
    else
      full_messages = {full_messages: @job.errors.full_messages}
      job_errors = @job.errors.to_hash.merge(full_messages)
      render json: {errors: job_errors}, status: :unprocessable_entity
    end
  end

  def update
    if @job.update job_params
      render json: @job
    else
      full_messages = {full_messages: @job.errors.full_messages}
      job_errors = @job.errors.to_hash.merge(full_messages)
      render json: {errors: job_errors}, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy!
    render json: @job
  end

  private

  def job_not_found
    render json: {errors: {full_messages: ["Job with id=#{params[:id]} cannot be found"]}}, status: 404
  end

  def job_params
    params.permit(:title, :company_id, :start_date, :end_date, :city, :description).merge(user_id: current_user.id)
  end

  def set_job
    @job = Job.find(params[:id])
  end
end
