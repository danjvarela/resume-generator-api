class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, [UserSkill, Resume, Job], user: user
    can [:read, :search], [Company, Skill]
  end
end
