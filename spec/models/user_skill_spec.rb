require "rails_helper"

RSpec.describe UserSkill, type: :model do
  subject { create :user_skill }
  it { should belong_to :user }
  it { should belong_to :skill }
  it { should validate_presence_of :years_of_experience }
  it { should validate_uniqueness_of(:skill_id).scoped_to(:user_id) }

  it "should create a skill with the given name if it does not exist" do
    expect {
      create :user_skill, skill: nil, skill_name: generate(:skill_name)
    }.to change { Skill.count }.by(1)
  end

  it "should ignore skill_name if skill_id or skill is provided" do
    skill_name = generate(:skill_name)
    create :user_skill, skill_name: generate(:skill_name)
    expect(Skill.find_by(name: skill_name)).to be_nil
  end
end
