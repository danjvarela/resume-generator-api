class EducationSerializer < ActiveModel::Serializer
  attributes :id, :level, :field_of_study, :start_date, :end_date, :created_at, :updated_at
  has_one :school
end
