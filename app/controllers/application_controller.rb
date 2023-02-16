class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  rescue_from CanCan::AccessDenied do
    resource_not_found
  end

  def render_errors(resource, options = {})
    options[:status] ||= :unprocessable_entity
    errors = resource.errors.messages.merge({full_messages: resource.errors.full_messages})
    render options.merge(json: {errors: errors})
  end

  def render_success(resource)
    render json: resource, root: "data"
  end

  def resource_not_found
    render json: format_to_error("404 not found"), status: 404
  end

  def format_to_error(*messages)
    {errors: {full_messages: [*messages]}}
  end
end
