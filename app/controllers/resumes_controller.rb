class ResumesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    render json: @resumes, root: "data"
  end

  def show
    render json: @resume, root: "data"
  end

  def create
    if @resume.save
      render json: @resume, root: "data"
    else
      render_errors @resume
    end
  end

  def update
    if @resume.update(resume_params)
      render json: @resume, root: "data"
    else
      render_errors @resume
    end
  end

  def destroy
    render json: @resume.destroy, root: "data"
  end

  private

  def resume_params
    params.require(:resume).permit(:title, :headline, :summary).merge({user_id: current_user.id})
  end
end
