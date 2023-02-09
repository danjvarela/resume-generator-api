class CompanySerializer < ActiveModel::Serializer
  type "data"
  attributes :id, :name
  has_many :jobs
end
