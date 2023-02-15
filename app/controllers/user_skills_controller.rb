class UserSkillsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    render_success @user_skills
  end

  def show
    render_success @user_skill
  end

  def create
    if @user_skill.save
      render_success @user_skill
    else
      render_errors @user_skill
    end
  end

  def destroy
    render_success @user_skill.destroy
  end

  private

  def user_skill_params
    params.require(:user_skill).permit(:skill_id, :years_of_experience).merge({user_id: current_user.id})
  end
end
