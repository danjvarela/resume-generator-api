class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  validates :years_of_experience, presence: true
  validates :skill_id, uniqueness: {scope: :user_id}
end
