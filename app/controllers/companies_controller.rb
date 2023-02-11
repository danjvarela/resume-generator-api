class CompaniesController < ApplicationController
  before_action :authenticate_user!

  def index
    companies = if company_params[:filter_by_name].blank?
      Company.all
    else
      Company.filter_by_name(company_params[:filter_by_name])
    end
    render json: companies, root: "data", **company_params
  end

  private

  def company_params
    params.permit(:filter_by_name, :include_jobs)
  end
end
