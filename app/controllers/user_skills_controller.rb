class UserSkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_skill, except: [:create, :index]

  def index
    render_success(current_user.user_skills)
  end

  def show
    render_success(@user_skill)
  end

  def create
    user = UserSkill.create user_skill_params

    if user.persisted?
      render_success(user)
    else
      render_errors(user)
    end
  end

  def destroy
    render_success(@user_skill.destroy)
  end

  private

  def user_skill_params
    params.require(:user_skill).permit(:skill_id, :years_of_experience).merge({user_id: current_user.id})
  end

  def set_user_skill
    @user_skill = UserSkill.find params[:id]
  end
end
