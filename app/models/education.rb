class Education < ApplicationRecord
  belongs_to :school
  belongs_to :user

  enum :level, [:Elementary, :Secondary, :"Upper Secondary",
    :Vocational, :"Undergraduate Level", :"Graduate Level", :Doctoral]

  validates :level, presence: true
  validates :field_of_study, presence: true
  validates :school, presence: true
  validates :start_date, presence: true
end
