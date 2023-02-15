class UserSkill < ApplicationRecord
  before_validation :create_skill_if_not_exists

  attr_accessor :skill_name

  belongs_to :user
  belongs_to :skill
  validates :years_of_experience, presence: true
  validates :skill_id, uniqueness: {scope: :user_id}

  private

  def create_skill_if_not_exists
    return unless skill_id.blank? && skill.blank?
    self.skill = Skill.find_by name: skill_name
    self.skill ||= Skill.create name: skill_name unless skill_name.blank?
  end
end
