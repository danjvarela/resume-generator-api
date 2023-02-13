class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  validates :years_of_experience, presence: true
end
