class CompaniesController < ApplicationController
  include RansackableController
  before_action :authenticate_user!

  def index
    render_success Company.all
  end

  def create
    company = Company.create company_params

    if company.persisted?
      render_success company
    else
      render_errors company
    end
  end

  def search
    render_success ransack
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end
end
