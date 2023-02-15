class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :jobs, if: :include_jobs?

  def include_jobs?
    @instance_options.deep_symbolize_keys![:include_jobs] == "1"
  end
end
