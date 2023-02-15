class Skill < ApplicationRecord
  has_many :user_skills
  has_many :users, through: :user_skills

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
