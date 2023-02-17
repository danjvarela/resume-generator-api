class SchoolsController < ApplicationController
  include RansackableController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    render_success @schools
  end

  def search
    render_success ransack
  end
end
