class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume, only: [:show, :update, :destroy]

  def index
    render json: current_user.resumes, root: "data"
  end

  def show
    render json: @resume, root: "data"
  end

  def create
    @resume = Resume.create(resume_params)

    if @resume.persisted?
      render json: @resume, root: "data"
    else
      render_errors @resume
    end
  end

  def update
    if @resume.update( resume_params )
      render json: @resume, root: "data"
    else
      render_errors @resume
    end
  end

  def destroy
    render json: @resume.destroy, root: "data"
  end

  private

  def set_resume
    @resume = Resume.find( params[:id] )
  end

  def resume_params
    params.require(:resume).permit(:title, :headline, :summary).merge({user_id: current_user.id})
  end

end
