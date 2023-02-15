class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date, :city, :description, :updated_at, :created_at
  has_one :company
end
