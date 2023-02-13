class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  def render_errors(resource, options = {})
    options[:status] ||= :unprocessable_entity
    errors = resource.errors.messages.merge({full_messages: resource.errors.full_messages})
    render options.merge(json: {errors: errors})
  end

  def render_success(resource)
    render json: resource, root: "data"
  end

  def resource_not_found
    render json: {errors: {full_messages: ["#{controller_name.singularize.capitalize} with id=#{params[:id]} can't be found"]}}, status: 404
  end
end
