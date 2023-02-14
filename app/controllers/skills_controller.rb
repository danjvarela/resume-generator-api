class SkillsController < ApplicationController
  before_action :authenticate_user!

  def index
    render_success(Skill.all)
  end

  def search
    render_success Skill.ransack(params[:q]).result(distinct: true)
  end
end
