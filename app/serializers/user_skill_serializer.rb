class UserSkillSerializer < ActiveModel::Serializer
  attributes :id, :years_of_experience, :name
  has_one :skill  
  
  def name
    object.skill.name
  end
end
