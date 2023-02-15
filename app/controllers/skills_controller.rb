class SkillsController < ApplicationController
  include RansackableController

  before_action :authenticate_user!

  def index
    render_success(Skill.all)
  end

  def search
    render_success ransack
  end
end
