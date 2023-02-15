class ResumeSerializer < ActiveModel::Serializer
  attributes :id, :title, :headline, :summary, :created_at, :updated_at
end
