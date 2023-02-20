class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, [UserSkill, Resume, Job, Education], user: user
    can [:read, :search], [Company, Skill, School]
  end
end
