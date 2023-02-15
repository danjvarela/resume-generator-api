module Ransackable
  extend ActiveSupport::Concern

  included do
    def ransack(model, params, result_opts = {})
      result_opts[:distinct] ||= true
      model.ransack(params[:q]).result(result_opts)
    end
  end
end
