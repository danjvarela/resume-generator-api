class EducationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    render json: @educations, root: "data"
  end

  def show
    render_success @education
  end

  def create
    if @education.save
      render_success @education
    else
      render_errors @education
    end
  end

  def update
    if @education.update(education_params)
      render_success @education
    else
      render_errors @education
    end
  end

  def destroy
    render_success @education.destroy
  end

  private

  def education_params
    params.require(:education).permit(:level, :field_of_study, :start_date, :end_date, :school_id).merge({user_id: current_user.id})
  end
end
