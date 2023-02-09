class JobSerializer < ActiveModel::Serializer
  type "data"
  attributes :id, :title, :start_date, :end_date, :city, :description, :created_at, :updated_at
  belongs_to :company
end
