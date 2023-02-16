module RansackableController
  extend ActiveSupport::Concern

  included do
    def ransack(opts = {})
      model = controller_name.camelcase.singularize.safe_constantize
      opts[:model] ||= model
      opts[:result_opts] ||= {distinct: true}
      opts[:params] ||= params
      model.ransack(opts[:params][:q]).result(opts[:result_opts])
    end
  end
end
