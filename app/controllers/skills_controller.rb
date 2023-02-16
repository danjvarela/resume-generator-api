class SkillsController < ApplicationController
  include RansackableController
  load_and_authorize_resource

  before_action :authenticate_user!

  def index
    render_success(@skills)
  end

  def search
    render_success ransack
  end
end
